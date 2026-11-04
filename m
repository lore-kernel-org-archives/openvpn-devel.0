Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47D606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mmYxWi0N;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Enbxo+0+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WyYAN7fO;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gAjc3OcL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jxbWD/zVUqtLPlCEiDnjRgiwdwF7yMjBGrex7GowD4I=; b=mmYxWi0N2sHwih669ctloDgrOA
	6aiJG+0Kc0Zje1ns8hYGMjEW1HNO2bRPGOGNQqY0f5XdmG97TAz7BTN5o36Lhn/tIjvy5z7LNPabc
	FPKMOlUMDsahpBp1TMpNdJS3KKhOU6Fe2lJ6wBoeEEQws7XO0NsvdK1GBB8DnsyCWWIQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeNu-0000000053n-1FpS;
	Wed, 04 Nov 2026 17:02:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOeNt-0000000053c-2jgW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:02:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7kluJbdYjJIsURcIMtR/pTVyZ8hqnQqleHiWrrmbWvw=; b=Enbxo+0++OghqUsbmJL6ekH7ct
 1JYzcQ0yv9ps56jW27Y4NWOUv4pLLaW8ltSH4FboKMCVmdR6Nm+FzmrSo/UWb2WRSElRJqKJ0Xf0U
 qlAq7NihLMhh1fNXchdrJyJQg5xcJqhP69IycTv1L7QjR88LoFziK3nfhzMmMcP+JyRA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7kluJbdYjJIsURcIMtR/pTVyZ8hqnQqleHiWrrmbWvw=; b=WyYAN7fO+wznalUX3TUv5XNR34
 eXee/CF1JtJvhNTsPFtk/25HSIIvDW/Zcw8L1J4mIyoPfRYl6O4OnI+eAxGVxQ6CFJl+r+QWDRWXS
 XrDSFTL2+9jenDJPou7Wfv08XXX3IztdfO3oiy5qjOYBUVybLgze2lwFsgZb17SfvGHc=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOeNs-000000001eu-0wYQ for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:02:49 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso8514455e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 09:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793811762; x=1794416562; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7kluJbdYjJIsURcIMtR/pTVyZ8hqnQqleHiWrrmbWvw=;
 b=gAjc3OcLQynlrhmcanHzEjHCQOcU82AxHa+NXD7JCdnSQpVeMvDlRgJU5C6JSuUul0
 aQY/PW2PiVkfNeRnBKZLt7v50SJGHhjFXwxfyKpcRM51BEc8xc+BGg43Q1AItNmDZ/T9
 0uZw6cccRXN5em6ogOpA6lKO/isC5639qpQCc626PIsbJL9uYyhATo9vkdBBlEUzjdcL
 q1ZZuuUc5j63NvjZlXgSvSAyX1VawbebuNKyfkxfO5U1IalpTcJdXBLYMmTjPFrpJe+f
 qkNggS+kjKABGETjcsQOtkbfUwnR4yp0z2vULhPAIoHbC02l6lPoQpLMXLCLLyF1/z5R
 18nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793811762; x=1794416562;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7kluJbdYjJIsURcIMtR/pTVyZ8hqnQqleHiWrrmbWvw=;
 b=24xOmppNQ5ekqTMSDWTWCP05kdnWYa7KPgJwiYQkAT0NvlFMskXMJZtPPJBbmcZXLT
 gtMff2FSc2d6IQE4aMjquZMzkNxNoRj+EumXDanAiLGu+9XRjfPktS2EaIYoy3C7dRnL
 ohn86OHBP4CpuiXNuugCOhI3JAsfBEBC3i1DM3Kzibo72HhU4xT+2e6kh0kkBkpx0zyr
 nMGGnvsHEDX64hVXPx+0CCwiNhrjFdbIhS+IbowKc+ZxgbvXl+rk1sQHpYFbjD7fGPFE
 XfO0PpDDBxS6PcZSfxje5o96wFNgkFYE6KjdhxeaejVN0rDgjczwjhlutDQPxrBsTV7s
 QEZg==
X-Gm-Message-State: APuU4Z+vgZGZ1xEEJD+YiOdbQDoVk+KBzTA1ggKE5ofKyeRUQ98SPNN/
 2GMJH+/jZNiGCzAcBP9nk8KfE4CM/ifHO9S0tzLLmvfXlnMA6aIsPgwNmT3TjotVOYfS1QVilct
 ajOshHFI1ReOprU4H8PW7cGmcNpuo3QWWzJO7SjLRY96jF/SOR9cRHzmuIv9bA2MyRyQs
X-Gm-Gg: AYBFou26KzPXtVJL2QG5N6dJqH7TYuwh72ZCxzyKsMkpVzIDturmMVmCW6E/8dOZn+x
 rxQyRi4lJLw+18r6zOKaHOIubHbiAsgdiMPNR2tPizDv38MQ9C2quDziqExZAojjgrs4I566pmf
 2ADy4suAuHP2HBKmepN1DMsDQt2NJjI0syTuOl4xThObCXMrze15yYHAxqo+WvYULs/0CX8DL2n
 1LDutaueFnmoTf9FReU7GKr5MYH+HvWWEH67GvnEZ1xZJCbIaAFCf/O7yFjImgVrqmkpGkvYkrF
 m2XuitlvhidZqD/Aog6V3GGyJOmmLGwArCRaMBIfM+cuFljcdwRJGsmQVjxS4QVCFLZ11QbEnBW
 shGYgBr9yk7zpIdOHur1IXhmJt1Anuvbg58/GcPEWbRDIKHgOlFoK8UkJzoWWGQvkV4XoBx20up
 zkEPqBrl18wL0ghhIC9HMHePxSej4jewOwZq5ynaJ+9+kLDt6qc8+LNVJxcPlJeEVvC6pyrFsMs
 Ual9JJB8UsrogfCfH8qZLG80VZse+MfeVKECGZvR/Lj+318+nGIX8OlnBduNSddAmcQ+yWVt7SD
 N1UnpeFApWrUfl903N8tSB8rR5kBtKNy/ZNGyPFhJ7Id/7KFRdsqJtzKHhg5I8Uk4FnLb/UbpwC
 LfVrPMknUmA3/8c2OLPJPyxwbyLHejZVLAhOmFFVwzJ4PTSR9CSfWeiZ9yo4Nl721nv05iUSMhH
 inYDQzYz5yxTCQ0Y/Xn7kS3T0oNkT4CaK6g1Y=
X-Received: by 2002:a05:600c:8b0a:b0:4a1:742e:3 with SMTP id
 5b1f17b1804b1-4ac185bc4a1mr378888435e9.27.1793811761404; 
 Wed, 04 Nov 2026 09:02:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed45d7f7sm5136282f8f.38.2026.11.04.09.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 09:02:41 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 17:02:39 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8b9efc75656e01df9afe99c280ba8c9c82e937f0
X-Gerrit-Change-Number: 2120
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2120?usp=email>
X-Gerrit-Commit: 719f5c2c19037262a0758dc2f7e504ff7958b23e
In-Reply-To: <gerrit.1793776960000.I8b9efc75656e01df9afe99c280ba8c9c82e937f0@gerrit.openvpn.net>
References: <gerrit.1793776960000.I8b9efc75656e01df9afe99c280ba8c9c82e937f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2OTYwMDAwLkk4YjllZmM3NTY1NmUwMWRmOWFmZTk5YzI4MGJhOGM5YzgyZTkzN2YwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b2493d259a8c36c35305bab819dc12293f178688-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOeNs-000000001eu-0wYQ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: log the actual
 error in Windows tun_read_queue()
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2486218781510617351=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2486218781510617351==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R/KkZp69JzY="; charset=UTF-8

--R/KkZp69JzY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2120?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: tun: log the actual =
error in Windows tun_read_queue()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

tun: log the actual error in Windows tun_read_queue(=
)

The read error message passed the ReadFile() result, which is always
FAL=
SE on that path, to strerror_win32() instead of GetLastError()'s
err, so it=
 never showed the real error=2E

Change-Id: I8b9efc75656e01df9afe99c280ba8c=
9c82e937f0
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2120
Message-Id: <20261104124931=2E18525-1-gert@gr=
eenie=2Emuc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/2026110412=
4931=2E18525-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@gr=
eenie=2Emuc=2Ede>
---
M src/openvpn/tun=2Ec
1 file changed, 1 insertion(+),=
 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/20/2120/2

diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
=
index 7637dc0=2E=2E943ad9f 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openv=
pn/tun=2Ec
@@ -3305,7 +3305,7 @@
                 tt->reads=2Eiostate =3D I=
OSTATE_IMMEDIATE_RETURN;
                 tt->reads=2Estatus =3D err;
     =
            dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read error [%d] : %s", len,
- =
                    strerror_win32(status, &gc));
+                     str=
error_win32(err, &gc));
                 gc_free(&gc);
             }
     =
    }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2120?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8b9efc75=
656e01df9afe99c280ba8c9c82e937f0
Gerrit-Change-Number: 2120
Gerrit-PatchSet=
: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--R/KkZp69JzY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2120?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">tun: log the actual error in Windows tun_read_queue()<br><br>The read e=
rror message passed the ReadFile() result, which is always<br>FALSE on that=
 path, to strerror_win32() instead of GetLastError()&#39;s<br>err, so it ne=
ver showed the real error=2E<br><br>Change-Id: I8b9efc75656e01df9afe99c280b=
a8c9c82e937f0<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2120<br>Message-Id: &lt;20=
261104124931=2E18525-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ek=
ernel=2Eorg/openvpn-devel/20261104124931=2E18525-1-gert@greenie=2Emuc=2Ede<=
br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =
src/openvpn/tun=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/20/2120/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn=
/tun=2Ec</span><br><span>index 7637dc0=2E=2E943ad9f 100644</span><br><span>=
--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><=
br><span>@@ -3305,7 +3305,7 @@</span><br><span>                 tt-&gt;read=
s=2Eiostate =3D IOSTATE_IMMEDIATE_RETURN;</span><br><span>                 =
tt-&gt;reads=2Estatus =3D err;</span><br><span>                 dmsg(D_WIN3=
2_IO, &quot;WIN32 I/O: TAP Read error [%d] : %s&quot;, len,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                     strerror_win32(s=
tatus, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                   strerror_win32(err, &amp;gc));</span><br><span>         =
        gc_free(&amp;gc);</span><br><span>             }</span><br><span>  =
       }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2120?usp=3Demail">change 2120</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2120?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b9efc75656e01df9afe99=
c280ba8c9c82e937f0 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2120 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--R/KkZp69JzY=--


--===============2486218781510617351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2486218781510617351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2486218781510617351==--

