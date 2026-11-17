Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F47606A32F
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RcgRUNw0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TsNmiO3/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=c7rc7/lf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IXjMvsa4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ybqo4GEsX25LdOvfdduaivEnW7F/ptfCfYXBxF1ofXM=; b=RcgRUNw0LeiKj0t1gaywiKRsss
	k2Z1jx3ujxVejb4avpdzVfseMufNl8NrpiL4Oc5OwoKhTWu4OZk/tz1BCz+bRzm4bDiyn4F00TAyR
	gkj9fUiK0yKZ1TE2l/ekO1rgQXJ43a3FDK0HiShUyAOqxc7/w0DPnKq6HhORi8zmupyc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTLEx-000000004sB-360o;
	Tue, 17 Nov 2026 15:36:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTLEs-000000004s1-2f3D
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 15:36:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ytPWpdloNRwHTg3HdnLXu514ynoMpXq+yeRl+QB3uFA=; b=TsNmiO3/4fv12KDLYHw0S78+XR
 +O/EC10ld18QgpcMu2vGu2WtU3JEmaE6PZ3xY+WfL4N/VvDbJYawsM7BoFCNHgjWSN8TvUzYtHla2
 UVoikDyN/LP2QPfsSXj+k2u4VD5Rz1F+i36QhMBTyAB8CDMJ2Rs9n+Hh8cD4oV8rSDFs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ytPWpdloNRwHTg3HdnLXu514ynoMpXq+yeRl+QB3uFA=; b=c7rc7/lfG7JSVci7F73UtAx4T5
 lecwupVYB/eBc0PLUTw4s/uIbLYMheFoW1zPdLv72HqlZL9yTYvfN+tIMpIlJDgEebhdz4sVkE4Tf
 yuK/VjVOWR9Pzb8ERmLXv2pBVp+qsFOFJejUg4t+5m25t9dZmN0JieQsfjeNhT7WHuCo=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTLEr-000000001gd-1pzP for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 15:36:54 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so34673375e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 07:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794929807; x=1795534607; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ytPWpdloNRwHTg3HdnLXu514ynoMpXq+yeRl+QB3uFA=;
 b=IXjMvsa4Qq1lbzz/qja3dUMEfUwUDUaSkRiA6vPPOlDgrlYvKUKoAHVUIsxm/jEw3O
 Nhitd0zltDYwD8xV9knzXYrPtV6RZe5S4g8/SyILr7kXprrpr2qxIhaOSw6HCgzUTwAT
 +nZdDyesDb7tvVGDg0iiH9fnaRXAeqqZjrT1TGsJMw71pXzgr9XeOVBVAxItSPk9j8jp
 b4vBwjz+i1t0bUreVQ8z+9pno6eK6+yaQ5jEEaIn8umJh/cA/ABFyplJm6xvpcjkwnjn
 SS5yoBlXac+9phy2lmmbCOp4774Y4++SmixQUQ3GfyhiuKvB8sJUggIs8Sssw6u6U04f
 4S6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794929807; x=1795534607;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ytPWpdloNRwHTg3HdnLXu514ynoMpXq+yeRl+QB3uFA=;
 b=ZplD2TjvnXSfIxdRbtK+f1t3GYcucV85UxGjEKEh55gr+z/s8FKdruyK9M3k97aJ4C
 uYTTXz4XvtTPhZ2DIm8vduWdu2dtojAGsOecCta6dSbTG/ArMoUdmaWe0FD03RBeqZoD
 PdZLkpjGACj8C65EVm2gfVVCpfDlciMyuvYOKcxIZUT0x1bD151IK+35q7xALhIYH7dt
 +qeOt846QO/slsXJqV96QLycBefxLNg6ZBhtArd3SvWtrsrU4OPxYJda0Vytyg4CEmVj
 Wsz/I/T0vwWnrA7YimqNAr2Z97WZfKRwJCNCQqgPbi4c/0wi8IuFSrL3+rRZUY855nWl
 JrtQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFqWc/zSrcf7C+XFSyq5EBdaQQwUVHYUKsUZrXuiku3Vd2wjo7Rk2P53q75FRxEaRB10BI/pq5HAhCQzQZH@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+pMer2NpYItUcOvtLF7H1LY37EXanNMoWBQvfZ7i1Ykh9udfnc
 gCOuow0bdWdY5l8KHWCOteCzW950CkbqirtNBHZatjAyDeayj3fsbr6Pmzbxshbrn/fG2Va93/g
 qJsPaiMO+vY3o3EwTPJOS3PWq9P5Scq63dWmLFyRHCPZjYuiUBqnZ+h1Y+UGNshvfXf+TgYjtlk
 ON8YnEFg==
X-Gm-Gg: AYBFou3Dm5MyKHuQPFFz5UFKQQLX8GvCFFFqTf+lHpsSjn/XNy5jW8RLNb6yhsVx6MD
 92xW8c/skXIRIF8A+Huh99szMtL3OXE2Hh/hXKVXwxp9VnnFe5PRfa/8lvBVXg2Nyc6rUPp5btr
 /KCBCIufzEYgITCXL07UiZPrDeN0KVn+7MSPdvPvE+Z4845MH0tV1jFT9BXRHWM8AhY8FFLH9LX
 p26cv0Fw9i8xwp+hjiZNyl/RibXhs5LaHBEWsQJntqz6dXseFOsM87za1aZaDSAVgL2kBOnmu5I
 tb0htUFrRXSzJuHmQATELa6i399z7BhMpUcimZ47mNLpERAl6CzGnGF59UZbuCgrqy7fXddkb4b
 cpnVjbpQOtucLT7R1sxlMUt/4sXTJoOajNpTfgt1AZIKjTi/qspfVifLWZrVbFF60nEj1fDpuXf
 WWOmHlLwGxAX2b3apGFRFHf++C5FmeJbM9gCvT0G0JFQZyMqRlns9TJFVb8+v3fzzT5ytgkjuzd
 TDjxdQeBe5XLLJmE9EnVdMjLn0zOtMDYuSPmSPkYAXzhUdJirfpJcczWEl0AWWA+sBDR7hBp/H2
 JIPectNKPXt+BEVeADlhr5RUEgM71A0aA8xvtiLukbNwSBiC7qbqETPc/6MWXO/tXOcPrfHjacW
 ZPtpdB4ea+X0LMzFDhdv1kfy00X6Y5RgAN1PAFDmFUFVUjpx7QZO9WPg2WeptrPSgcnaHEeZyTL
 TXfXc/ZlR/ZWbluyI=
X-Received: by 2002:a05:600c:8b65:b0:4bb:62d5:4ab1 with SMTP id
 5b1f17b1804b1-4bb62d54ff5mr232711925e9.33.1794929806561; 
 Tue, 17 Nov 2026 07:36:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb784e9073sm80405515e9.6.2026.11.17.07.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 07:36:46 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 15:36:44 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
X-Gerrit-Change-Number: 2210
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2210?usp=email>
X-Gerrit-Commit: 6e544f6320d31ce0143df4a8253cb988a4e4c8b4
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 15:36:44 +0000
In-Reply-To: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
References: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkk5NzgwNDFlYTRlNjMyM2Y1YTkyZDg3MjE4MDlmMGZhNDRiOWMyZTAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <60ac611f0023df5e47ebfa3a18897dc762ec2a01-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTLEr-000000001gd-1pzP
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: pause the
 listeners when accept() runs out of resources
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
 gianmarco@mandelbit.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6343832734346929850=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6343832734346929850==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WijsKmE7V2w="; charset=UTF-8

--WijsKmE7V2w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Gert Doering has posted comments on this change by Gianmarco De Gregori=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail )

Change=
 subject: socket: pause the listeners when accept() runs out of resources
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:=
 Code-Review-1

(3 comments)

File src/openvpn/manage=2Ec:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2210/comment/4cc79654_4f56a18f?usp=3Demail :
P=
S2, Line 3325:                 if (man_persist_state(persistent, paused ? 4=
 : 1))
what is this `4`?

I'm afraid this patch needs a bit of doxygen comm=
ent on top of `man_persist_state()` on what this is doing=2E=2E=2E


File s=
rc/openvpn/socket=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210/com=
ment/bd369ef8_7e3abf98?usp=3Demail :
PS2, Line 434:     const bool out_of_r=
esources =3D err =3D=3D EMFILE || err =3D=3D ENFILE || err =3D=3D ENOBUFS |=
| err =3D=3D ENOMEM;
please sprinkle a few braces over this - there's too m=
any operators for mere mortals to grok this (`out_of_resources =3D ( err =
=3D=3D EMFILE || err =3D=3D ENFILE =2E=2E=2E)`) or maybe just get rid of th=
e temp variable and put it into the `if()` right away (having two `if()` wi=
th the #ifdef, not one with #ifdef nested into the condition)


https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2210/comment/9d04688c_8537f519?usp=3Demail =
:
PS2, Line 438:         accept_resume =3D now + 1;
can we add some logging=
 here?  This will create spurious "connection refused" on the client side -=
 which will show up in logs and will make people ask "what has happened her=
e?"=2E  Of course we do not want to log this once per second, so not fully =
trivial to get right=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2210?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
Gerrit-Change-Number: 2210=

Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@mandelbit=2Ec=
om>
Gerrit-Comment-Date: Tue, 17 Nov 2026 15:36:44 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: Yes

--WijsKmE7V2w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Gert Do=
ering has posted comments on this change by Gianmarco De Gregori=2E</p><p>P=
atch set 2:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail">=
View Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage=2Ec:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2210/comment/4cc79654_4f56a18f?usp=3Demail">P=
atch Set #2, Line 3325:</a> <code style=3D"font-family:monospace,monospace"=
>                if (man_persist_state(persistent, paused ? 4 : 1))</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">what is this `4`?</p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">I&#39;m afraid this patch needs a bit of doxygen =
comment on top of `man_persist_state()` on what this is doing=2E=2E=2E</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/sock=
et=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210/comment/bd369ef8_7e3abf98?usp=3D=
email">Patch Set #2, Line 434:</a> <code style=3D"font-family:monospace,mon=
ospace">    const bool out_of_resources =3D err =3D=3D EMFILE || err =3D=3D=
 ENFILE || err =3D=3D ENOBUFS || err =3D=3D ENOMEM;</code></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">please sprin=
kle a few braces over this - there&#39;s too many operators for mere mortal=
s to grok this (`out_of_resources =3D ( err =3D=3D EMFILE || err =3D=3D ENF=
ILE =2E=2E=2E)`) or maybe just get rid of the temp variable and put it into=
 the `if()` right away (having two `if()` with the #ifdef, not one with #if=
def nested into the condition)</p></li><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2210/comment/9d04688c_8537f519?usp=3Demail">Patch Set=
 #2, Line 438:</a> <code style=3D"font-family:monospace,monospace">        =
accept_resume =3D now + 1;</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">can we add some logging here?  This w=
ill create spurious &quot;connection refused&quot; on the client side - whi=
ch will show up in logs and will make people ask &quot;what has happened he=
re?&quot;=2E  Of course we do not want to log this once per second, so not =
fully trivial to get right=2E</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail">change =
2210</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2210 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco =
De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 15:3=
6:44 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--WijsKmE7V2w=--


--===============6343832734346929850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6343832734346929850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6343832734346929850==--

