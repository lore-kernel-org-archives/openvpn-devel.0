Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCAD606A326
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cNSAbeDd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ldPiDc+0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=d/M7HwjJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ghs/EO05
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CxaeyDPpbe739Arc8SuFhJwBa9tLAonwdOV0bgNIuNc=; b=cNSAbeDd3E9Ar30KL70RKZyDYI
	gQQATaDK+8/F8h1RcnD7Jk+gjJDvEsBza4xTTmfvbnCmFRuKew+sRdD8mazM3GgWaWJXHQoPwx6LN
	OZ4rdBXMDx4XUTESaZLsJchN5DFgoDPU2KEKZnbTjXK5NkCi7CpqSM0+l1DfpTD+D/r4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUMBl-0000000069H-18Ye;
	Fri, 20 Nov 2026 10:49:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUMBj-00000000698-1Kjx
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:49:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PjeCNgGENZDhj0r3YAVZRrxiIhviBFt7X/klKo53pD0=; b=ldPiDc+0tzzI9sFm74KeP1915w
 TXo3xCvve10yofVdbYFLNRT3pUIaQMJ1nqUkV2s5iQX89ogKJlfSiT0/nn6wtPdTEGO6VkObBtMHV
 yL0NPm+B8vZCExTsV/nmzGfsCkE6WJG0kr8okqhAvpSrYq/wWju6ehvYjlRT6jNErCUY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PjeCNgGENZDhj0r3YAVZRrxiIhviBFt7X/klKo53pD0=; b=d/M7HwjJDmAuu1Uo9KDy+PSnh+
 JEuRw8o8QcxnSIDfgy6orOSTaBcX7aP/CrOU9HQ7IqYXRUl0Wq5HKMF0Kj9ctndZscymCAW55nmi5
 5f++rPSdJznvUe1j37bdejcliN4gqeXQ7XWLm7wpFSVywA/CYeHlzzXtAiFtDHvZ3rpM=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUMBi-000000004Gf-2T71 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:49:51 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so407664f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 02:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795171784; x=1795776584; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PjeCNgGENZDhj0r3YAVZRrxiIhviBFt7X/klKo53pD0=;
 b=Ghs/EO05i+TF0AIcqsn5urZKXu8BbTfiDWh7zQRAXDP1NZ5rfa3WmtX2lVGMR1q1Vl
 CLOMfOqNXQqkQloa2Qtu5kbOqbG5KqaUJgUfYd0TupuMX32pVSpw+BDwunNfwFp0m6AG
 KTFnjW+VBl9Nx9VCrrBw+sS0uEij/TT/E/f7PK2+KHXGSmnnMgZTPktng87BiyyzDI7q
 H0sRxtI2ZKRu4WXDtrp+t+w6TvdvDq2XYemHdzAEZTvd1HTUAxxTbZRXv0ZaEW1FL5TY
 tpJUW0sV2ZvcHFkbilO5qu1ZLERfzjUAU1Oe7jpE/CG9SL1La12V+xQgjLpCioed27tZ
 65/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171784; x=1795776584;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PjeCNgGENZDhj0r3YAVZRrxiIhviBFt7X/klKo53pD0=;
 b=NWL0C4U9ZtqlzoTXhQZyQkwAQFPSQ+C2FQgGFI7/tiZT95p/cmetl/30Sk+cC6WUDI
 B45cUw77lAYnoGyTUAC1b6nGJ/uhdAf2bMe+rWI2UtdrvdHMhaN8fv8o/dZjUbqhujUF
 uIC5EbbQ40LQwBd49UglB8a3IhmZMpa/0VjCVEEUqnXbI25L1vCPqck8EZjSyNXY9wsK
 c/eSnLCToVYaEr6EK5ZUKe9MYy1WTRQt+1Dn3iDZ9MPkEMkiC4c2CoU4UJigV1AXDO8Q
 Mhxz+dlLF7j7zC1DprFntHUhrg1rTarBI2j/k03kWd0OthxHJh9AL6n24ib7K4ocLl2O
 Lz+g==
X-Gm-Message-State: APuU4Z9YvHN2i5SfikYmZb/wgQ0V/8XIyJ1gFrOm8mdT90lbB2bR5xeD
 j6yWuVFhUaCjUlcm/7CjCny0wP7Kfbw4eg5qCsQKrubQ1cYBncMlqva9TFFeAJQPLWXcc9uNlhf
 /aKwwgPsCAJPEWyi8/xvXsxEeLaMiFOLFfdEK1tE5iKwQgBntlOHOAAlwCwlhKgxytkxR
X-Gm-Gg: AZFdTZdfse8MZGUuTt3H/8dSZL1ncTjXXTTl/h/kwaOfGS5Dixfmbe+iG08hqVdHQF0
 sQrfOVYBbos7E9gLaRya/zCaCPE1eTlpWxn980QDw/M6/65QfWqcamPtwVGkllRzLYqatErDBeb
 9m47UvQm8KNNKUlUme+izYAMLfQvPnAfBZDhgAn+mZGyJbZHqpa22oOQZyYOQi2hQe+7RTEbya0
 yoML5WGxKZEEmOj9J2ldO8DjZu4k0BAv9UhE9oOBh+YMknTQgE4z2QlnxRBgMFLTFym3wclGLZV
 ZmMJvoWPfCeKpmOtJzxwevig6VD3E595dGpyqHvY2ps3ZlTl0L1wO+HRraWkKFCq7IXArPSK+Zu
 CSnLL4QVshTnjA+AhsqnPmfaVxbbVqhg8JHqegIsT7BPl81IIiHw+z/R16ZQ1pYaXR3n+uICl7n
 EpBB+f90B09Z4oBf93tW//Nj9W2q5nj5adeHfA7bFYn26Qo1pZG5srDlf6/QqF9U+hai7KpyD9V
 GngI0AS0Qc6ziBlHPY8ah1gV1474zHjO8uIaYhGoALqdkep+owxPmsgYZ66++6M9gFchHQTP/t7
 fv0CPmamUzr3AKhJh+0uZfoZ2Hhr0P8tKiOa4adTjiODOYf7HuUVmQzOh1Y0i8b6FJ7a6FuzuHP
 N8t42wap2m/c7q0e2CmtKyXHCI41EcEua6xFWxt3K6zRsK9gje9qYMyYH+xgMZDkRSwoLRlmuCs
 Xs3gdInAPr6zUz86c=
X-Received: by 2002:a5d:6f13:0:b0:4a7:a7d2:eb45 with SMTP id
 ffacd0b85a97d-4abb6d04777mr4394445f8f.44.1795171783829; 
 Fri, 20 Nov 2026 02:49:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989b3sm5097761f8f.51.2026.11.20.02.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:49:43 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 10:49:42 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7e70d73f494382e99933d48eef67ecb50a52ee1e
X-Gerrit-Change-Number: 2221
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2221?usp=email>
X-Gerrit-Commit: 0ca53540fa64bb63774326550341be33ab1c1def
In-Reply-To: <gerrit.1795074255000.I7e70d73f494382e99933d48eef67ecb50a52ee1e@gerrit.openvpn.net>
References: <gerrit.1795074255000.I7e70d73f494382e99933d48eef67ecb50a52ee1e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDc0MjU1MDAwLkk3ZTcwZDczZjQ5NDM4MmU5OTkzM2Q0OGVlZjY3ZWNiNTBhNTJlZTFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f7cb372f78d9ef3b95fde04c01c05056430d6384-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUMBi-000000004Gf-2T71
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove
 .svncommitters
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3406146966972497173=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3406146966972497173==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JLT/Y///ZVE="; charset=UTF-8

--JLT/Y///ZVE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2221?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: Remove =2Esvncommitters
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove =2Esvn=
committers

git-svn authors file from the 2010 SVN import, only read by
"gi=
t svn fetch -A"=2E The author mapping for history display
lives in =2Emailm=
ap=2E

Change-Id: I7e70d73f494382e99933d48eef67ecb50a52ee1e
Signed-off-by: =
Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greeni=
e=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2221
M=
essage-Id: <20261119074802=2E20392-1-gert@greenie=2Emuc=2Ede>
URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41661=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
D =2Esvnc=
ommitters
1 file changed, 0 insertions(+), 1 deletion(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/21/2221/2

diff --git a/=
=2Esvncommitters b/=2Esvncommitters
deleted file mode 100644
index 0772102=
=2E=2E0000000
--- a/=2Esvncommitters
+++ /dev/null
@@ -1 +0,0 @@
-james =3D=
 James Yonan <james@openvpn=2Enet>

-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2221?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I7e70d73f494382e99933d48eef67ecb50a52ee1e
Gerrit-Change=
-Number: 2221
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--JLT/Y///ZVE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2221?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Rem=
ove =2Esvncommitters<br><br>git-svn authors file from the 2010 SVN import, =
only read by<br>&quot;git svn fetch -A&quot;=2E The author mapping for hist=
ory display<br>lives in =2Emailmap=2E<br><br>Change-Id: I7e70d73f494382e999=
33d48eef67ecb50a52ee1e<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2221<br>Message-Id: &l=
t;20261119074802=2E20392-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41661=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>D =2Esvncommitters<br>1 file changed, 0 insertions(+), 1 deletion(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/21/2221/2</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/=2Esvncommitters b/=2Esvncommitt=
ers</span><br><span>deleted file mode 100644</span><br><span>index 0772102=
=2E=2E0000000</span><br><span>--- a/=2Esvncommitters</span><br><span>+++ /d=
ev/null</span><br><span>@@ -1 +0,0 @@</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-james =3D James Yonan &lt;james@openvpn=2Enet&gt;</span><br=
></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2221?usp=3Demail">change 2221</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2221?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I7e70d73f494382e99933d48eef67ecb50a52ee1e=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2221 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--JLT/Y///ZVE=--


--===============3406146966972497173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3406146966972497173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3406146966972497173==--

