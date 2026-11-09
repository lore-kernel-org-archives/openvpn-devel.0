Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42FA606A334
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LBhAexkc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=D9j/7NZe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bwF0pjQX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LffMVTYJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fxonHi9beqfqdHAwAxKGP35rXC11632f9SVEvaR0tRI=; b=LBhAexkcNC4KuY91/l1ro+1TRs
	yA2FIffxeqenLOn6MUunL16gakmIFUG8nYzDcqRLh9q9IrZyqmJd9pM0S87/Cs12ZQE9lYD/pAef3
	argSKrSp5feBjjGXiBKEWT1vL8CQLqjjcmwpAJiSPwypc9hjlke5LZrPvyvS2nQvgAyw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRSQ-000000001a0-1r2l;
	Mon, 09 Nov 2026 15:38:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQRS6-000000001Zh-43BV
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:38:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NBFAsoKXLGG5f1EMBiOCoc+4wQ9Y1JANUsoVp9VUlIU=; b=D9j/7NZe8ieVAFK5a/wmNVGTHO
 MJWjsjIJZX6Uuov3UOb7fWbtgF0vo6H8xwUf9Lt7o/NpqCUJLVlFdYl3Je4DIjrrKwyMsPJwiHmIK
 hVJiODEr0TNbnQy08SNqgXHSd6bIjy7KpT7EjXbF4iHH9gSnVdNcAD/Z9taBiiXdnzh8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NBFAsoKXLGG5f1EMBiOCoc+4wQ9Y1JANUsoVp9VUlIU=; b=bwF0pjQXKGzDa3AcApcBhJuez4
 EgHZYttL2xgabF5Y7RtGPVmSomSy3yRHSyjixkLOzRlxDEw1OA/4j0sR32e6fY4HSAhHImzlNapzo
 PgjZGPaYED90XXAcTjSjXyHXK0OpjJDFwJU1GYRFmbVvjVqz8nNm+y4ZJUhXXvPovYmM=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQRS1-000000001G6-3vNY for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:38:31 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-491d1f66968so126515f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 07:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794238703; x=1794843503; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NBFAsoKXLGG5f1EMBiOCoc+4wQ9Y1JANUsoVp9VUlIU=;
 b=LffMVTYJbaH7lP6Rmp/MhCfmB8N1sAKIpl2UOZJYPchr9T7ni5vd11uRZzE2ZuAdQz
 HhKhqbDGKf47kVf+sMGTMdudDsH0QhI0IHDqX/3woi/giatv365jSW1Ph++0fKtAW/Sh
 /DLufKp8xKMrhUtu4obODnE/UvRrk5LKI2ndKnkMHs4uzBMEOAAMx2Pc23exkgH4NxDX
 BZ0VCxGg7vNLItZgqAMPFr5JD6/S/JpSpmP6sHmo/8ynsvBADm9Q0/Y5AH3HhSPsOeAk
 PNjULLy3IHQozxg8kWCMSy2p8r4Clsla1P4laDcSk276zKYbxbt4PGVOgQmIGnlk1S79
 Fpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794238703; x=1794843503;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NBFAsoKXLGG5f1EMBiOCoc+4wQ9Y1JANUsoVp9VUlIU=;
 b=p59PKsC6nWsuv3ex+rc186pU7499wIRKCNojsGM+AWhCxtlK4viJfEJnbU34W81pB7
 O1mdTr0pZ/4HgEy9y3jtEkCUKVh5ZUkQ+aKYlNAvRxWMM0sfMdmNW784NnUY9BM9XoKK
 A21bm8V2l8mqNHGpZA+uL5InviRY4qSOV0xLO9xlnoZqEAZ5Zp5uNfVnvNkaaDMwWdBw
 ISOaGwNsvFHhKAV6jKXz40k0qMOXn2Ao11SFhvqq9fMgr9dJLy14SudserbDc0qG2VAr
 aEZ0P9VeZXe+8ZDNw7mmR32ytfDjPnBN8KxXLVcsVp8JdEhpIbWuO0rP+eKm+1Qh+Z+j
 GH5Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGGKyw8a2hM5pVK2MVXNcJwWKu8l1+hH6pNEKfKH96lXmWRLLtEdMzUvt0p4ZvleexFtWuHy6aCrqzq8b3U@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9MfARbAUn+HpI59hpGY0BMGVo360RIgAvYookwZFNRL/EWNUi1
 88CWXNi1zGeDlQOE8mbcoj3DMJu4p5nBrVvsKUfO5RDXSNszkzXJJ2grQbcYNcKprEOH3xjZpFG
 Irm0/5PuNZj6JcPjNRPuiH+xKIsJcSXX9shR3Xe5BindhuqMpJYMaiv6NS3+AK5wW2cez
X-Gm-Gg: AYBFou2Y4zJ0pdnj6mHIbZAOwFS+T9KX6vUw3YpXAuZuPvEt3LiPiLjLzQTH8cu/M7n
 59txaEkXSXd9Rwu0n0DbRpUl33aQSQRpLR3CnsUpWHMZfQmE6yTIOaE9WoOnRZsiVJEGCBAtFjY
 HDSo3zorTClIl5aUjVC61rorAeLr9dCAmeSBu5EiH+KcXQdm8z8Z8FuvqkzH5kR7SSxUZi3R4cE
 VbzwN8AtSu9zsV57O3XAUhBVOKKlZxC65wh61Z0Jhc4CHPK1v2vi08VOLVRWIWot7qGk+XjohY5
 Jo1FkOTOs4OtcNggh5hMjxM2mNEanbnds1OZjjrJhTa/UtjkA3w13WgrRcegzp7IHcEQJ/740uD
 8uHWIgID4KrvewC5C0dTHM7ll2IxIGuodB8c0PFLzF0o1JI9UFypBT/oEfNGtghpdhthGB2jHfe
 Ugr7YMmIYmsgwdPr5TlP8uIGY6wkwMT2jX6JBKzYDDTONPD4UAlmb2u+tCBPHJM7V53X2Oav1wk
 /ae8N7BZbjLwRTj+65cv5FkhuOMhRnx8YQYZj/OHwGEWgu2Avbqpl3sU7GZNu9OJ6UktFYj226N
 PCou0ycFaX6FW+u0+0PPufN/P8Q5eirj/+6/Nv7DYl6VH+4vcxbRlgmHP6mwN8/mIGgvcw014gB
 29Ldju6mvXLi4XPyMHcxUEwfMYfRHhs7YtcTXwmsqyLisBbxGKIyfv9KeX4lAdaGXS6DgzDSItV
 ef9xlG5IClaiAtacg=
X-Received: by 2002:a05:6000:186e:b0:48d:f7c0:97c0 with SMTP id
 ffacd0b85a97d-4958c49735cmr8978111f8f.50.1794238703205; 
 Mon, 09 Nov 2026 07:38:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49592f3a7bdsm8635423f8f.1.2026.11.09.07.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 07:38:22 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 15:38:22 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4bc08f4d7d8e5b33f951a3340df187da7253449e
X-Gerrit-Change-Number: 2100
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2100?usp=email>
X-Gerrit-Commit: fa8914210c31ea0dfcde20715cf40f7792412e52
In-Reply-To: <gerrit.1793689251000.I4bc08f4d7d8e5b33f951a3340df187da7253449e@gerrit.openvpn.net>
References: <gerrit.1793689251000.I4bc08f4d7d8e5b33f951a3340df187da7253449e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg5MjUxMDAwLkk0YmMwOGY0ZDdkOGU1YjMzZjk1MWEzMzQwZGYxODdkYTcyNTM0NDllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eebbcc244c664eb9624d8bf87eb263b709bc7fa6-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQRS1-000000001G6-3vNY
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: options: remove
 dangling pre_pull_default() declaration
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4051850022956909179=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4051850022956909179==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E4NvrmAtVWE="; charset=UTF-8

--E4NvrmAtVWE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2100?usp=3Demail )

Change subject: options: remove dangling pr=
e_pull_default() declaration
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

options: remove dangling pre_pull_default() declaration

T=
he function has no definition or callers=2E The declaration was already
dan=
gling in 6fbf66fa ("This is the start of the BETA21 branch=2E=2E=2E"),
the =
oldest commit in the history, so the commit that removed the
definition pre=
dates it=2E

Change-Id: I4bc08f4d7d8e5b33f951a3340df187da7253449e
Signed-of=
f-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2100
Message-Id: <20261103074747=2E6269-1-gert@greenie=2Emuc=2Ede>
URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40=
549=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/=
openvpn/options=2Eh
1 file changed, 0 insertions(+), 2 deletions(-)




dif=
f --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 73c1354=
=2E=2E33b50b2 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/option=
s=2Eh
@@ -943,8 +943,6 @@
                            uint64_t permission_m=
ask, uint64_t *option_types_found,
                            struct env_s=
et *es);
 
-void pre_pull_default(struct options *o);
-
 void rol_check_all=
oc(struct options *options);
 
 int parse_line(const char *line, char *p[],=
 const int n, const char *file, const int line_num,

-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2100?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I4bc08f4d7d8e5b33f951a3340df187da7253449e
G=
errit-Change-Number: 2100
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--E4NvrmAtVWE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2100?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">options: remove dangling pre_pull_=
default() declaration<br><br>The function has no definition or callers=2E T=
he declaration was already<br>dangling in 6fbf66fa (&quot;This is the start=
 of the BETA21 branch=2E=2E=2E&quot;),<br>the oldest commit in the history,=
 so the commit that removed the<br>definition predates it=2E<br><br>Change-=
Id: I4bc08f4d7d8e5b33f951a3340df187da7253449e<br>Signed-off-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@green=
ie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2100<br>Message-Id: &lt;20261103074747=2E6269-1-gert@greenie=2Emuc=2Ede&gt=
;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforg=
e=2Enet/msg40549=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt;<br>---<br>M src/openvpn/options=2Eh<br>1 file changed, 0 insert=
ions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options=
=2Eh b/src/openvpn/options=2Eh</span><br><span>index 73c1354=2E=2E33b50b2 1=
00644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/s=
rc/openvpn/options=2Eh</span><br><span>@@ -943,8 +943,6 @@</span><br><span>=
                            uint64_t permission_mask, uint64_t *option_type=
s_found,</span><br><span>                            struct env_set *es);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void =
pre_pull_default(struct options *o);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> void rol_check_alloc(struct options *optio=
ns);</span><br><span> </span><br><span> int parse_line(const char *line, ch=
ar *p[], const int n, const char *file, const int line_num,</span><br></pre=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
00?usp=3Demail">change 2100</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2100?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I4bc08f4d7d8e5b33f951a3340df187da7253449e </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 2100 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit=
-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--E4NvrmAtVWE=--


--===============4051850022956909179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4051850022956909179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4051850022956909179==--

