Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C633606A327
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VekxaCbv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GywSbNK9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ax5NgS3Y;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Sw5wJrRz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=mGy6rphWTnfouhAo1DMQeQ1PtjXX+RWDrlo3+tttOMw=; b=VekxaCbvBUhH7vUb9FFLKFtDhE
	glzbfqQfTjPYje71qH3x2BCNAXmGDE4w/jiq4CamexK0LWpo19gtmArcsN9gb6bvz/y1YG29deQPW
	DDSj6t84E6KZQHw6HCVROWtXm9VJWbdkEbRzQXAdGzbcqifUD/ujd+szc1RkuwJI+ULM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrnh-000000003kK-37Yl;
	Mon, 02 Nov 2026 13:10:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNrnf-000000003kC-2qwm
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:10:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cp5mumryjQcgWW0YUzvkOCw7kHYPg63guiY0Suy0iLw=; b=GywSbNK9aHdrjc20KcGDqS7jBb
 4blc7MvW+oT39QuI8mlR6X18WDrKFD3Kw8xb+uQGQiizyqMp5JTR5rgkFy4R378WBPNQqfWM9vUS+
 k2QoINe4W3/wkNyGcWd2d08rMegzWmDYem0CSES50zs5Z7KoqzWubQty3eq+ZhZH4Wss=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cp5mumryjQcgWW0YUzvkOCw7kHYPg63guiY0Suy0iLw=; b=ax5NgS3YY5bt6nCzJYKiky8Wyo
 IafEq32yxxzY65+I4fnX5gApdzX5DL7OKbw2N9I0z34StgJ/lvrJM95nKAG9t8uxCMSDQxCHB3zkx
 sf4O1ujfvhlONe8wgRnypmAhfmUDBcCd/7IPgtSVwQIIhuwy+7ba8WUJ6JOhqTlX1BYo=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNrne-0000000081d-0egS for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:10:11 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso1440342f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793625003; x=1794229803; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cp5mumryjQcgWW0YUzvkOCw7kHYPg63guiY0Suy0iLw=;
 b=Sw5wJrRz6lCOFOaIUY+R4bc2MeChYotpGFtjxB4evUKT0zX8tjJ6bYPbveOFMO0ZdG
 w4zwhm5Eeu4ftFbInhlhes/s21jwqiyx7w26U5xgS0WYUbJWx2Rw7ryr+1ZD1uWX0QmW
 P8Petdau0TspYhn3gcVsNs7Z6uKhYukF5v9tcj2QQoH4ZruXQ9vpDRgMgbpwr1XEPEH4
 E4pC9BzdQP9REVAA2KsltPsCHTM9NtjZMWVU7Uh9saqW3G3eaFAlTXc2aZNdw83JKMHq
 Hst6Nw7NgmYzY5+9cjCwZHrLdJ2IYdrzPN64nhuzcASwL9r5cmr5lcrxLhedSk2u8zKX
 UWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625004; x=1794229804;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cp5mumryjQcgWW0YUzvkOCw7kHYPg63guiY0Suy0iLw=;
 b=gaeYhgQACNwskaG1e78ASW97wPoUmxbek5bHK9dZa0joEd7UXS8zW8dssZKQr9Cecb
 x35NqTOKwxz8Es/LTB/OpPLsWbWxirmvziczvyQ8sn9QpcoefwY36QaSN1t/0/WP9+Zv
 N/T9Fo6dZXVs7i8F0OhuIeQB2kOoo+YYhgDJj44CEXrfGDlfSexKqBHPCpO9H3jROJY8
 HI8iMqGCVyRVVnjs+U1837AjtPcoDUb52ij1y18Xkrl+u1KAOn2ak6sRRKbIgOzCLZkl
 WLBoDYoXWmVpB5gW8OjdtwFbjcsd7Gn8id2hM60cVqDjeaaDNzzsD937OaWwz4LAhTcj
 An2w==
X-Gm-Message-State: APuU4Z+1umwm4jVkp0RdiqOKri6t5Zy+3d5CoBhJmUR/OzrG+vSZ2XhY
 8MlBLBTmGo4zAls4r7vUcBIlbfOTWrwjk/tr0Ybi1nP70Keat4llIE9mQmfLf/v4iTTId3DV6g6
 wHWq+egdLKEC89JD3zmip8jDn+85qXwFOcNgtK9RmLTQKsfUk8jsjeLyhwrBC1YF9QNoefUDHyY
 Iq5i8EjQ==
X-Gm-Gg: AYBFou29c0j33NGIj15E2eP4HYqTThcjAl57aqrU3wosUXvbGpevE33Virv/cr4T/TH
 9xUZSxBQzJBead/MKkI4tOK9NW7/iuS8B4DpZf+/hYgJKf2OWk3ncSZnqy9Z4CtNpIactCco7u3
 ictq8aXxzAYs32x34xoy00UUnAOlUSPxog2Yb5TZTazZh4Eoipshkl2VM+VFOjdLTamT6CYpxOj
 qbFvOfXpzXoy/PbCR22yNiCnxKlU8Oz5pK5v0yIelSKiYUqskaLlkO6Ao76h6y73foTUeTyAwt5
 wLtS5JQM9ONRoR9M618mcp5vriq9vuJiGolqBcZo4VeEFsQ6gMBMvNTTyBZHCi85agJPoSOXdR9
 ybuiZMXFSTeeCcMVb2e/NBR+9EnIS8urDJKNnj1vFryKvApvfZ5/NUR5ga3Mj3uNK++7PNa8bIr
 KUnYIDH5CIwIiyxKGKf8alf61x0/ockqep7hVzN0sgiuw3xKpXzIMgLwFt6o+tlrP7mCZDumzk+
 95mTK7zouX27547htdUkv5XeIBtLMu2peZadsc41UEzCOPHwPqGHo6JAllvcTK/o9a7C7V+iqn7
 dmBjzBV+Q07NdhHhEWnIYaMBZhF4OBFGtDdBufpAMxMSPq7D625J6LB8bhzDjDF6HZcZk0io8mF
 PDTTVEF4/MNgeyjb1ivsuZSAExjcuBh+mprjenoUiv5dLbggLp1ZMpOBROTlbogaHiAApTQ6b1i
 cmBsxyjuRQxYncCuEjX71kNE+INXs0r7qRhcI=
X-Received: by 2002:a05:6000:2885:b0:48e:353b:9f28 with SMTP id
 ffacd0b85a97d-48e6e2c2536mr21215825f8f.1.1793625003405; 
 Mon, 02 Nov 2026 05:10:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba4ac6sm21289925f8f.52.2026.11.02.05.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:10:03 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:10:02 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I73efe00fddbd919897489c975ec65ed4b4628cc8
X-Gerrit-Change-Number: 2091
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2091?usp=email>
X-Gerrit-Commit: c8a59738f0bd1c62dec682ae85b33082da53241a
References: <gerrit.1793625001000.I73efe00fddbd919897489c975ec65ed4b4628cc8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjI1MDAxMDAwLkk3M2VmZTAwZmRkYmQ5MTk4OTc0ODljOTc1ZWM2NWVkNGI0NjI4Y2M4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6766efa20e0daf63f66bdb94c97ae4b12c4a93b2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNrne-0000000081d-0egS
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: close first
 pipe if creating the second one fails
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
Content-Type: multipart/mixed; boundary="===============1323561482775739295=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1323561482775739295==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0pgA+cQXv5I="; charset=UTF-8

--0pgA+cQXv5I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2091?usp=3Demail

to review the following change=2E
=


Change subject: dns: close first pipe if creating the second one fails
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dns: close fi=
rst pipe if creating the second one fails

run_updown_runner() leaked dns_p=
ipe_fd when pipe(ack_pipe_fd) failed=2E

Broken since 1dfe8729 ("dns: suppo=
rt running up/down command with
privsep")=2E

Change-Id: I73efe00fddbd91989=
7489c975ec65ed4b4628cc8
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eo=
rg>
---
M src/openvpn/dns=2Ec
1 file changed, 8 insertions(+), 1 deletion(-=
)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/91/=
2091/1

diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index e5ed1b=
c=2E=2Eabe30ed 100644
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@=
@ -608,11 +608,18 @@
 {
     int dns_pipe_fd[2];
     int ack_pipe_fd[2];
-=
    if (pipe(dns_pipe_fd) !=3D 0 || pipe(ack_pipe_fd) !=3D 0)
+    if (pipe=
(dns_pipe_fd) !=3D 0)
     {
         msg(M_WARN | M_ERRNO, "run_dns_up_dow=
n: unable to create pipes");
         return false;
     }
+    if (pipe(ac=
k_pipe_fd) !=3D 0)
+    {
+        msg(M_WARN | M_ERRNO, "run_dns_up_down: =
unable to create pipes");
+        close(dns_pipe_fd[0]);
+        close(dn=
s_pipe_fd[1]);
+        return false;
+    }
     updown_runner->pid =3D fo=
rk();
     if (updown_runner->pid =3D=3D -1)
     {

-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2091?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I73efe00fddbd919897489c975ec65ed4b4628cc=
8
Gerrit-Change-Number: 2091
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--0pgA+cQXv5I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2091?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">dns: close first pipe if creating the second one fails<=
br><br>run_updown_runner() leaked dns_pipe_fd when pipe(ack_pipe_fd) failed=
=2E<br><br>Broken since 1dfe8729 (&quot;dns: support running up/down comman=
d with<br>privsep&quot;)=2E<br><br>Change-Id: I73efe00fddbd919897489c975ec6=
5ed4b4628cc8<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>---<br>M src/openvpn/dns=2Ec<br>1 file changed, 8 insertions(+), 1 del=
etion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/91/2091/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dns=2E=
c b/src/openvpn/dns=2Ec</span><br><span>index e5ed1bc=2E=2Eabe30ed 100644</=
span><br><span>--- a/src/openvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/=
dns=2Ec</span><br><span>@@ -608,11 +608,18 @@</span><br><span> {</span><br>=
<span>     int dns_pipe_fd[2];</span><br><span>     int ack_pipe_fd[2];</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (pipe(dns_pipe_fd)=
 !=3D 0 || pipe(ack_pipe_fd) !=3D 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (pipe(dns_pipe_fd) !=3D 0)</span><br><span>     {</=
span><br><span>         msg(M_WARN | M_ERRNO, &quot;run_dns_up_down: unable=
 to create pipes&quot;);</span><br><span>         return false;</span><br><=
span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
pipe(ack_pipe_fd) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(M_WARN | M_ERRNO, &quot;run_dns_up_down: unable to create pipes&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(dns_p=
ipe_fd[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
close(dns_pipe_fd[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span>     updown_runner-&gt;pid =3D fork();</span><br=
><span>     if (updown_runner-&gt;pid =3D=3D -1)</span><br><span>     {</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2091?usp=3Demail">change 2091</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2091?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I73efe00fddbd919897489c975ec65ed4b462=
8cc8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2091 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--0pgA+cQXv5I=--


--===============1323561482775739295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1323561482775739295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1323561482775739295==--

