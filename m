Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B960A1DAA
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FyeIYZyT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cjq3nIJx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kBg6oGbD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=confwDqh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oW5gGI4VJm2xC4mO1woV7dw80r7LwbZxoa3dd/6T+Po=; b=FyeIYZyTUYN0rwKLnqMDAp04pJ
	HGMqIIFE/r9/B3qjfh9+dE52NYe9AQgXLuzJ9nUoXHBIXMBRRK+cvueygULRNjmTKwiPBdPzaKVGI
	Bu1qQrhUazdKyZjR5ZLQpvt0zZ7Dx+ZgElnyyAMj0TOOxadP/3Q3t2t0DvxlDoNoL868=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNv58-000000002mw-0GPm;
	Mon, 02 Nov 2026 16:40:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNv56-000000002mq-3iZp
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:40:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PiBuAJIyY+7OJ+aThjllcaW/TDjKkb6lIH++WOYpJL4=; b=cjq3nIJx41Ix9z1mmXSO2rGUGd
 dSJ+rYSCweTMQ1+fAjVc+TsbQ8nrUnQGZ+K+ol1RKk0oDH/A7pNIoXp/G2BUvMJTGu7fEK1l8JAIs
 HEArIpTasm25dd8Vu3QhlFCmFdcOl+TqSspEQOng8NuOZIZK/388Ee/SXJoqtBDTVftM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PiBuAJIyY+7OJ+aThjllcaW/TDjKkb6lIH++WOYpJL4=; b=kBg6oGbDXQ7wOCLLKGv5PC2XCN
 bX87zj1bpS0tbgd7V6qFhthb+9It4uDaaP298sXJkNx2LtNpsqfbrLVVvoYGqqq7/Ot9GE0pC2+8Y
 FOX2A4RWCEbdI5rw7Fyi8B/nNU0m8H+ESEEMNt3u2ESVKFuoMf8KWVs87iBSjQYUZ0U4=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNv54-000000005S5-0T7J for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:40:24 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so29089565e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 08:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793637615; x=1794242415; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PiBuAJIyY+7OJ+aThjllcaW/TDjKkb6lIH++WOYpJL4=;
 b=confwDqhREDpV25moPG8FHnWWJRQyVng99/BIitdilc32BfoLDrDfIoiXPxRCUZPC/
 InKJGKzQMrbKCMV/qV54bbixRoRypEr1s+f+d0r0fvQeOg1gxqGHIJaKNsVa1n5x7TDu
 4CB7ESqmnbWNIYXTPqkjeSjRZ41yAsGTUUNMSenSvTl+HY2kPgFioceRI1qOzrBJY+at
 f/TOBJicSZ5Yk5HyrsF2sJ7uKeKjLfFSCC+/KULCvnaBE5/7NhanryJj+fn7t8xlPT37
 WW3EQImBRoO8VcrFsBu3Lz5QiFUmR4M2IRc/eoX/cPMy0/+HZVC2BpgVdy5upeE5i7+7
 La3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793637615; x=1794242415;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PiBuAJIyY+7OJ+aThjllcaW/TDjKkb6lIH++WOYpJL4=;
 b=vFpQrboGduTl1J6IDdzA14ukNSZTFXNt5MbiC92uOANtD4ydLFP6RR3aeBdI86nQSj
 +UvxIJAz0+1UnVVd49i5UHhoCoPnWymuGvceT72j9sFi6uGqx+IgAmuuSKW8ygIjVJ1G
 AIpTBA5fqojczQ9uhpyVGl8Cv48PTxtDylx3IPkJmKVt1q1fyAjWkDqzVyDtHY4ujv3m
 oETLDcDJ7b79LRGOCbdYN/REQngeyIso+FySfnHgU9gvPmca477Oht4yTqKOPbVU+MWg
 EvCpX4ocxm7FdfZh+Kg7yqZ+TdC5aA0UM3WT0idRDpT7lYlRTYDtR8PBNdIOtUVJiR/2
 wDaw==
X-Gm-Message-State: AFq9FYI/AI7Qj2wSqMfr9PHiV0odgQIGVWbbyMIeHtTx7wXImDjakDzg
 FM2RKfp0ZuLd2z2BAkI84iRNi8Npct2Uxr5sQHzwxy7aHbOFxiqyNAZiUEy2ArF/alfJlR5RHmY
 4WkBmdw0He26oo6VtjJnL3LSKiUU3AIevd3YfjqtCwq98pCqAIzaOLTCIPzxHFEX/ZzSEie759y
 +CUyBHFA==
X-Gm-Gg: AYBFou3Itr/5RGWLQiZrl4mzxQXOkZT2hIYWe7lF629sPXJk1WKePr9QHDN47AGQROv
 SxJRJGDlHY087rj1tWspzk7V+UvrCVFFPL+xinkIZaNmFw5RjlQEWx2BbSfy1br/uH3CIPkOXlX
 5BNh0z7+ifrwswzAvVE14dXdFTTEtsy3/syGpeveda0F1MhArU0/CMG4fA0qkP7h4iPmuuYYpIg
 /IEWUBz2hBaKMvWddBikDTAXaRIh0KxofX0yEbocg2gkMTl8aC1O4jQWK3aRpqVTp6Owa0wM1dM
 RASEu3Hu8oGRIV0o9l7zY/H2guXTGquuYSOTgJNNmMXOMlXg5SZ1ZlpMVSs+ZxMk3VHe7inSM+5
 AsaRPPXUkRnz0rwo7U/Z8wi+Wg+i1hZeXcIZRYUfU6JlGkj+7zS/kPy8z8ifL4mjEJoui/aiS5w
 Oo2PXfEffHirQRNHbbD+KYKvRH7po3tMAQe379h4G/oi0LQqVyCxfrlXx+AzV2DbM/zCqh+k9sk
 GXVZ6uVo6NuLhJqPTixQqbPsYjYuhb6103br0mQIXGhhQhv1gFo2DijkeJkVIaALZKl3uvg5Xjq
 pNH7A8tYy3VaTZJ6RwrxhWG5EQZuiVYcHy/WlrcNvXSEf7VA7eCHSpTlaFHwFe2/mqvbv3Y3eDl
 WWf6HvKB/UpV7EsMN9ZUggmL23D8TzBbYqFT4xsNJvPT28WwnojwghF6pT7oIQrmaXc0kWxKzpQ
 LkGJxXJkSTp9mDyr8qonZYpJ2vmNmLU/yLdt0=
X-Received: by 2002:a05:600c:a012:b0:4a2:150f:1609 with SMTP id
 5b1f17b1804b1-4ac17b2cdffmr237868355e9.8.1793637615312; 
 Mon, 02 Nov 2026 08:40:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm355292725e9.4.2026.11.02.08.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:40:14 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 16:40:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: c6f1c752d4421e47ddb937aa0cbb5dad6361aeca
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 16:40:12 +0000
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f8f325d241853a78764656eb0a43205fc4a87a1a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNv54-000000005S5-0T7J
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate using the dpc1 ACC protocol
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7026467919933456025=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7026467919933456025==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8j0rXH7y/J8="; charset=UTF-8

--8j0rXH7y/J8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061=2E

Arn=
e Schwabe has posted comments on this change by Arne Schwabe=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail )

Change subject: Add p=
ython scripts that demonstrate using the dpc1 ACC protocol
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(8 comments)
=

File sample/management/acc_dpc1_client_demo=2Epy:

https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1860/comment/af32fec6_38f9bf89?usp=3Demail :
PS4, Line =
26: import asyncio
> Unused import?
Done


https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1860/comment/079c2400_c53f19ec?usp=3Demail :
PS4, Line 37: class=
 OmiAccProtocol(OmiProtocol):
> Shouldn't be OMIClientProtocol + receive_ac=
c_dpc1 ?
Acknowledged


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/com=
ment/bf7e29ec_055c99fc?usp=3Demail :
PS4, Line 40:         self=2Eaccmsg =
=3D ""
> Do we need it in class? It looks like a variable only in recv_noti=
fy_ACC=2E=2E=2E [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1860/comment/f7271cdf_219e7f5f?usp=3Demail :
PS4, Line 56:         self=
=2EparseDpc1(self=2Eaccmsg)
> should be snake_case instead of camelCase
Don=
e


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/96baa7e8_05348f=
05?usp=3Demail :
PS4, Line 62:         logger=2Eerror(f"Received sys_info m=
essage: {accmsg}")
> error?
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1860/comment/172dbfe4_11b5cfb6?usp=3Demail :
PS4, Line 79:     def _send=
DPC1ClientInfo(self):
> should be snake_case instead of camelCase
Done


Fi=
le sample/management/acc_dpc1_server_demo=2Epy:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1860/comment/aafbd8a1_f22becba?usp=3Demail :
PS4, Line 5=
2: class DpcConnectedClient(ConnectedClient):
> Missing typing
Done


https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/85f62847_0931a657?usp=3D=
email :
PS4, Line 117:         await asyncio=2Esleep(20)
> Why we need it? =
If we need maybe we can add comment?
Done



-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
Gerrit=
-Change-Number: 1860
Gerrit-PatchSet: 4
Gerrit-Owner: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #1000061
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Nam=
e of user not set #1000061
Gerrit-Comment-Date: Mon, 02 Nov 2026 16:40:12 +=
0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Nam=
e of user not set #1000061

--8j0rXH7y/J8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061=2E </p>
<p>Arne Schwabe=
 has posted comments on this change by Arne Schwabe=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">View Change</a></=
p><p>8 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File sample/management/acc_dpc1_client_demo=
=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/af32fec6_38f9bf89?usp=3De=
mail">Patch Set #4, Line 26:</a> <code style=3D"font-family:monospace,monos=
pace">import asyncio</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">Unused import?</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860=
/comment/079c2400_c53f19ec?usp=3Demail">Patch Set #4, Line 37:</a> <code st=
yle=3D"font-family:monospace,monospace">class OmiAccProtocol(OmiProtocol):<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">Shouldn&#39;t be OMIClientProtocol + receive_acc_dpc1=
 ?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1860/comment/bf7e29ec_055c99fc?usp=3Demail">Patch S=
et #4, Line 40:</a> <code style=3D"font-family:monospace,monospace">       =
 self=2Eaccmsg =3D &quot;&quot;</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Do we need it in clas=
s? It looks like a variable only in recv_notify_ACC=2E=2E=2E [=E2=80=A6]</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1860/comment/f7271cdf_219e7f5f?usp=3Demail">Patch Set #4, Line 5=
6:</a> <code style=3D"font-family:monospace,monospace">        self=2Eparse=
Dpc1(self=2Eaccmsg)</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">should be snake_case instead of c=
amelCase</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1860/comment/96baa7e8_05348f05?usp=3Demail">Patch Set=
 #4, Line 62:</a> <code style=3D"font-family:monospace,monospace">        l=
ogger=2Eerror(f&quot;Received sys_info message: {accmsg}&quot;)</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">error?</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/172dbfe4_11b5cfb6?usp=3Demail">=
Patch Set #4, Line 79:</a> <code style=3D"font-family:monospace,monospace">=
    def _sendDPC1ClientInfo(self):</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">should be snake_ca=
se instead of camelCase</blockquote></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File sample/management/acc_dpc1_server_demo=
=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/aafbd8a1_f22becba?usp=3De=
mail">Patch Set #4, Line 52:</a> <code style=3D"font-family:monospace,monos=
pace">class DpcConnectedClient(ConnectedClient):</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Miss=
ing typing</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1860/comment/85f62847_0931a657?usp=3Demail">Patch S=
et #4, Line 117:</a> <code style=3D"font-family:monospace,monospace">      =
  await asyncio=2Esleep(20)</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">Why we need it? If we nee=
d maybe we can add comment?</blockquote></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?=
usp=3Demail">change 1860</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1860?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1860 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: Name of user not set #1000061 </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Name=
 of user not set #1000061 </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Mon, 02 Nov 2026 16:40:12 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Name of us=
er not set #1000061 </div>

</body></html>
--8j0rXH7y/J8=--


--===============7026467919933456025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7026467919933456025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7026467919933456025==--

