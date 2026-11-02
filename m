Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FB6070C8F
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hugGu6xF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hNKjAc6c;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GOpZ9knO;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bSFG0Rx/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8nqloSVNnkyOVWRXgn0L0qwbffk5mbaK+mmE/ChO2YA=; b=hugGu6xFUB3Goqouqu8FS3ZA9E
	yFRtYyZcQH+ZUsqWEix5jwG1lnmqEjUSgS+94aBydRvLjCKi8GcWEyVTMT2wODhwb5CcL8cIDJlZU
	rBp4HUrSf1gQRwHZNgQXBNNRKhq7iGS16P3HGeT2YHgGoMjM7QV7ae4QXITODCKo94MQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNt2l-000000005bz-2iG7;
	Mon, 02 Nov 2026 14:29:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNt2k-000000005bt-17do
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:29:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nKYVI1gyWaKItx7V//FtWtUt4WacJ/msz1JJ84q9WeU=; b=hNKjAc6c2RRqt9Is3yO74I4hr7
 5h3HL3XGYonY3MY074hgCMx0iiOulA3CM/hlhjXBVEx5saIoKlRofQECox24tBjuV/Q2FS8vn9S48
 zfS+NUh15U/yOgnKfLf9vrWme9A7fJ39rXpvf4NWVdR4Qq24PiS6ZFcUp6WJRrBYIHXI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nKYVI1gyWaKItx7V//FtWtUt4WacJ/msz1JJ84q9WeU=; b=GOpZ9knOdZs5zXXd2TLRnBWm3w
 xDc+M9eTj6pFDybT57OuiMFxAVW0Zym692koISEnoOvcbSFb7m0iEi+x20Czkam2yofkI16OEPo9g
 IWLIhRoRDDpOdWRpd1fFapI04QznBKMulqRDg8bdZPS0sEzoyvvNnMLqH5HlYVCy6ZC0=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNt2j-000000001c2-2DIf for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:29:50 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so18693885e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 06:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793629783; x=1794234583; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nKYVI1gyWaKItx7V//FtWtUt4WacJ/msz1JJ84q9WeU=;
 b=bSFG0Rx/6Z7dqjLkfccnlD1TmtR5Rksm+C0tGpxlElMWONJn3JI0yak3V/W6bFbfpJ
 maR//zPocJG0lJlRsglEYA3trskIFcq0Ag+ypfvSe3OR8AoWw2nIsIesZ25CLfQ74NxY
 f9Gjubzeaffs9e7UkJHttFH9INeQSL0xZsx6CtzpvofBH/jA0sDlQ68rTe/Tn1kU9wXU
 XUT5b9RtrHm18nPhyjZ+GAJp9wMvZtvhSrIkySBXcrC8j36EgMser15Fx5qv7zK9F8bg
 SNkvg7kwKklQ1+Y41fmcyL8CQARmVgTmh8LQTPIHKEKQL+krkS3S1V3w0N16F4hzKpCX
 rjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793629783; x=1794234583;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nKYVI1gyWaKItx7V//FtWtUt4WacJ/msz1JJ84q9WeU=;
 b=maaKtqVWDX4RZGDPfe7XxFho9TtlrcFLLPQy9plGSV+lS5GAkZYkxJYVPV/Xy9syDI
 3qm902GUkP19mGrc6ohSmm6bsv925xdWYTK6TPyDZiXyTT8cd/WYU0z22bBma9+Skpiw
 kuzYH76kSD3VZ+KMqDk02wAA3ZnLvgVjUpbAqi4IP0hF5iohEtCfdJdIfERA4V3yuVgb
 ggUUChGu+fuGHkkcOzKS214sbVMy11KkXlOQTJ8Ylthxuq7rPvWsqM2xQPiToVMvIrTx
 o4eYBzAmGAVxD6uKbMoPt91aty0lfdLGbzj9BB/nTY5XTYeOoW89XLKCRYANtLXEmHf0
 or+g==
X-Gm-Message-State: AFq9FYJDzLGNUJ2cNCkEXwj+CTt7jWrCB8ozL2XAntXW71XVJfNBpEV6
 6S+BBKPCjq/3ACted8Wi1EBmtiWXz9DYENYYieHSUEYGJdUwIHY4Ohqlk4k375S4VoO8wN58Gpm
 gDWtnBhE+UYRFNXT0suZMcVOG8IKukskdYc+Y9LdOXVS7apLEznK0arkwNUKM+cI+/L5wCWRMJ9
 ZJJucB7g==
X-Gm-Gg: AYBFou0yiZGt+CvrI41PgL94jqEaylM2WI9y6OLMyA6yS7V6PqepIFwJxsK4hO/NtM9
 MPHe9Bw4Z7Z6c91oPdJRKZTpUI6FcXgzaPzaazidBs2bQsfBQnSIilf82hMGHEZzBWChETb52Xs
 vNjGHTj52pBR1yxokg7drXjpDszXxENHGPRiBj3nXQU1mFsgwtd7HiPiubDqWcm0BPAvisA2Omi
 pYoxLWfrCvavGyh01Zl00lEvA6k6Rvoh4ZbnDifkU4rXSE5W/emD1higwpJMU2VzvBRDaCPV/J0
 VjAoqh1+zLTEjqtnqGGL6OiIGltLaROtcZgr7LcZuC9mdw1/5awlgJHEp4nmexO3LBaTqRHxIGV
 12937M6rC2jwTrQlIvmGoPn1wpuvn2TXGyaH4xTf2wQiRQbHbn6xHT6g/n48TgYFhQ71Drfp4aY
 h9Dv0MrkKb47+IT++F4tCIujcPVQW39rPUQHMsbSMPaXNZo8AtAT+L2TuyFdXgV+EJ/i13h/rTV
 0hYHCjrUYBLYq5nyBVuSumRjTupzvOEwxLjrLHteWHNgdRoa+0aZ/lGDv8rcAkX5d/zyJrv/p1T
 H0TLliOjuZEfomJ/z1+QlD4XwXNgmk8Ixfl4Ke6kuPzlPd4wxKcpA7zOwuDBSZ8EkpqtmPGG8wd
 wSlsu7Xl3nMtafyBAd7z+44rfaWwK2GLO+nhA09MQJBZHzI1OlTw4Z3e38fF/WNR5wqtQxRzpLC
 rxM4QC+AhSWZo+p/Atb22UQ9YM0wvrnf21qww=
X-Received: by 2002:a05:600c:4f8b:b0:4a3:5a98:c279 with SMTP id
 5b1f17b1804b1-4ac17ffb07cmr230542735e9.8.1793629782766; 
 Mon, 02 Nov 2026 06:29:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6c76507sm295345315e9.10.2026.11.02.06.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:29:42 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 14:29:41 +0000
To: Hansaem Wi <hansaemw@gmail.com>, Steffan Karger <steffan@karger.me>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e
X-Gerrit-Change-Number: 2077
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2077?usp=email>
X-Gerrit-Commit: 21c8a682755c425c0830d25cc33643545d479514
In-Reply-To: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
References: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzgyMDAwLkk2YjQyNzg1ZGU5OWVlMWU2YjU1NWQ4YzVlNjFlYmUyYWU3ODQ1MTBlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <102b920930caf915a893f2941467592748bdd022-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNt2j-000000001c2-2DIf
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto_openssl:
 Clear PEM decoded key data before freeing it
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
Content-Type: multipart/mixed; boundary="===============6942786412334680869=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6942786412334680869==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aZbuBWScibQ="; charset=UTF-8

--aZbuBWScibQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Hansaem Wi=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by Steffan Karger


Change subject: crypto_openssl: Clear PEM decoded=
 key data before freeing it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

crypto_openssl: Clear PEM decoded key data before freeing =
it

crypto_pem_decode() decodes the tls-crypt-v2 client and server keys
and=
 the auth-token key, and frees the decoded key bytes it got from
PEM_read_b=
io() with OPENSSL_free()=2E Clear them with OPENSSL_cleanse()
first=2E OPEN=
SSL_clear_free() would do both in one call, but LibreSSL
does not provide i=
t=2E

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: I6b42785de99ee1e6=
b555d8c5e61ebe2ae784510e
Signed-off-by: Hansaem Wi <hansaemw@gmail=2Ecom>
A=
cked-by: Steffan Karger <steffan@karger=2Eme>
Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2077
Message-Id: <20261102131404=2E21605-1-gert@g=
reenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg40430=2Ehtml
Signed-off-by: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
---
M src/openvpn/crypto_openssl=2Ec
1 file changed, 1 ins=
ertion(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/77/2077/3

diff --git a/src/openvpn/crypto_openssl=2Ec =
b/src/openvpn/crypto_openssl=2Ec
index e6abd8f=2E=2E3c708c2 100644
--- a/sr=
c/openvpn/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -528,6=
 +528,7 @@
 cleanup:
     OPENSSL_free(name_read);
     OPENSSL_free(header=
_read);
+    OPENSSL_cleanse(data_read, data_read_len);
     OPENSSL_free(d=
ata_read);
     if (!BIO_free(bio))
     {

-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e
Gerri=
t-Change-Number: 2077
Gerrit-PatchSet: 3
Gerrit-Owner: Hansaem Wi <hansaemw=
@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Stef=
fan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--aZbuBWScibQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Hans=
aem Wi=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by Steffan Karger</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">crypto_open=
ssl: Clear PEM decoded key data before freeing it<br><br>crypto_pem_decode(=
) decodes the tls-crypt-v2 client and server keys<br>and the auth-token key=
, and frees the decoded key bytes it got from<br>PEM_read_bio() with OPENSS=
L_free()=2E Clear them with OPENSSL_cleanse()<br>first=2E OPENSSL_clear_fre=
e() would do both in one call, but LibreSSL<br>does not provide it=2E<br><b=
r>Assisted-by: Claude Code:claude-opus-5-5<br>Change-Id: I6b42785de99ee1e6b=
555d8c5e61ebe2ae784510e<br>Signed-off-by: Hansaem Wi &lt;hansaemw@gmail=2Ec=
om&gt;<br>Acked-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077<br>Message-Id: &lt;20261=
102131404=2E21605-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40430=2Ehtml<br>Si=
gned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/o=
penvpn/crypto_openssl=2Ec<br>1 file changed, 1 insertion(+), 0 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/77/2077/3</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_openssl=
=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span>index e6abd8f=2E=2E3c=
708c2 100644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec</span><br=
><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -528,6 +528,=
7 @@</span><br><span> cleanup:</span><br><span>     OPENSSL_free(name_read)=
;</span><br><span>     OPENSSL_free(header_read);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    OPENSSL_cleanse(data_read, data_read_len)=
;</span><br><span>     OPENSSL_free(data_read);</span><br><span>     if (!B=
IO_free(bio))</span><br><span>     {</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail">change =
2077</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2077 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Hansaem =
Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Karger &=
lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body=
></html>
--aZbuBWScibQ=--


--===============6942786412334680869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6942786412334680869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6942786412334680869==--

