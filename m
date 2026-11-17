Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415BF606A329
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KKaPHMTN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YVaGAe0q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZDecGu1w;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZMJMixWe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QJszytZ0pSWuk8+njuU6CBPPtUO6p4vDPqaeYemL3JY=; b=KKaPHMTNFvcHo06PgSxkYPy6Hh
	UoKsxw7gA+2gPEbptQ0GFRNDV0Osbwmq8kyFomZXnXkkon5p2tReCgHgX6R4a0zfa8tWM6vTJDA0p
	3ZgGUDOs1YR7DZjW83SQxUKzB/HLUob8/VMifYBxANTI1qRPZDkpCpTtPTLp+MWC/JEM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTJay-0000000012J-46cC;
	Tue, 17 Nov 2026 13:51:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTJah-00000000121-0os0
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 13:51:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8T+CoRkxNubLuZ2lU05VBjGfu7Bm47lsdKW+SPBsFY0=; b=YVaGAe0qlR15Twy7f19m2sQHoY
 09pQ5m47VpRYX/JbGnje82C3FXlMwAA8bEazVM8a9PnJ/PZXEqaSbd2p9sh5Va87DHFESoAAYxgfQ
 UDKNUj+lQLwqFjV5FQU9YTZPE5taBJ97gESwAp/QOV/cf3a8vjYgUTBB5VbV39IIQ9Tk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8T+CoRkxNubLuZ2lU05VBjGfu7Bm47lsdKW+SPBsFY0=; b=ZDecGu1w3ORoa5kkBP6dADoOuy
 c8Lo2rO1TVKmKvkOtT684YTjBNG/4hkQuX65vGqeMncxoaeM3a15IeDd93uoxuFDRdg0QJOz7Ich4
 UdBzuF9SJ/1ZIKgONcO5H4iqvHB1+/SloH9f4ujIm5rYA4nAVOAR6N+jxRPaKjuXPzto=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTJab-000000007JA-3fAS for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 13:51:16 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so48908935e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 05:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794923467; x=1795528267; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8T+CoRkxNubLuZ2lU05VBjGfu7Bm47lsdKW+SPBsFY0=;
 b=ZMJMixWe0jLz9T41jqO4zoXtsobpPwJsmg2eSV/pUZPxbpPJwzb9IYZbxrfeML1eJH
 1qTm5FO8GuWdI+k7yrgF86RmjHXPNYtp0xWrHNrGPn0JhyxQKEtHFDQkH2Tkc8ZvqfOj
 UHq8mP2tmwfsHJlNeK/H9M82n8YUbjdqA6Ek4bRSJ1Rfs9xyhnPofMwTWAxkKtc8lkub
 gVjo2XTv7rs9grU6g278SSIv44ZbL3pyTdIFg8Sb7fD9vuB1KC0urcHSv2UDXIMXVaIg
 Z+TDgIwbsuJ/U/8iQlYnbHL5bqRlBe6JOgfDjP2QaovVStMpy1deT25iM2a5YIW9po79
 JDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794923467; x=1795528267;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8T+CoRkxNubLuZ2lU05VBjGfu7Bm47lsdKW+SPBsFY0=;
 b=xQNQs/lQ2ttNxH8oyGLWI5/aD3ulH2F6/rr8aNC1tuDCQGVXkFyEbCDx8x9bYBUA+n
 j1EJ03lB/jRqg5mNL87KXxp43WOYdS3d1jYpEiRD/fMqoCbLlb0RlUT/uzYGvrkaFqXR
 O2ZefIHHN6j5iwHmRyqFXzdiXi+/YZjRcEJiXOf/mMMlMGVxhuAD+lLlekfz66ZnIt/k
 0LX9UbkM28zCM4b+pRcqTgY2tBkNlJSCRhg9OBtqd/3/AGLEVZvJ317e8yYLZxUIbE3l
 +6F88HdxVq+AO6FT/tw5Z9vfZTQviv4w5bBBnu3lMEb3bb+b2ee8sTmJokoHchQzg2TU
 dypw==
X-Gm-Message-State: APuU4Z8iPGPN+2hdnBW+RnR/YbOJ68K1WrAXo15mtJkbLzOEoMpFApCr
 CimQInEn6STQNCZ1cc2qwUjTCXbenPwPriORXSZq6QO6uKHmh7C4Jke13IytiB/TaYHJ9HiHle1
 hBfBsRQHVDq4Xjn3MbKUk3s8i+7M1sCWqtLwSXtD9Yuw/cbh3IO1rQgmjJRrfkdJcNQZn
X-Gm-Gg: AYBFou2FuRyobv3mKgyJ0tqY7sk7f0cqdPgmqJ4+I5rJ9al4602OlJ/p/BUF9M0njr8
 wdpV26AQLrWKYXBKUhsKiqjtNHivmvaX919DDa5hrpb0WsXKl/KgdpdMNhdlKgLC1ejbb1G7qS6
 VCHXQ8MtYIGvdr5lSiS6ckBwTbYIFAg3mc2vkglIT7CEzuR9fEjZcAtYe8oPAQ5fi7J1e0LUjCz
 X3ug0u7iqSY/UtHXhtmwzMycr/SmsSnpaSraKeOcBD1dOTG83G5yeipEgBTyzROKgbR7mhPzuIy
 tsdC7Y4ItjoIWru335rwzA0NoxHQbJHNSfd2bdIFjxGo1opFcFZv/wNwEGztxbO4uawb3qJVc2f
 nleQHUDVcNosVXCTopn+2RN9Ji1E7hcZcPF5E1nFZPOD0QCGzM1NGBF9SXBmF1PSLYB37MPs1eB
 evKyNtl5e5TccTIIqzpdR/0EH0jrqhVJAG5zfLsv8yl2BdkgWQ/N+42bSgW84BegXnlFlqk4HOF
 KNh2B6A3n2qlE/DdB2EaaPLR9wbaE3sVErpyB5csdA0FrBE2T5vJZBkKrhy24VQq6ZAn1q09aH6
 /CEmUGvnCRztH6s330N6kUbiZ5QnwTdRAa7yFTjfjxYPGxqHlKUBVB0+DVQ48e1rN9Lj4mPkvXu
 O3zaHiPAx+BS8vgDveKbTqhZWuxDfdhFD+wVXPjp2FbtqO44QCBKGDU2X7mtvRyV0lWqMDW2+B8
 PvtHo+tHa1ar99hORmaTQjHENpcQUGPisUJdVr
X-Received: by 2002:a05:600c:b50:b0:4bb:5c5c:8130 with SMTP id
 5b1f17b1804b1-4bb5c5c8255mr190413475e9.5.1794923467008; 
 Tue, 17 Nov 2026 05:51:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7840b05bsm103280965e9.7.2026.11.17.05.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 05:51:06 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 13:51:05 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I604fdff9c0a7cbbddfd025a72e6f19a96bb51753
X-Gerrit-Change-Number: 2190
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2190?usp=email>
X-Gerrit-Commit: 08f9865d6df33b9e4f253edf3a4152ca1cbdb803
In-Reply-To: <gerrit.1794828082000.I604fdff9c0a7cbbddfd025a72e6f19a96bb51753@gerrit.openvpn.net>
References: <gerrit.1794828082000.I604fdff9c0a7cbbddfd025a72e6f19a96bb51753@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODI4MDgyMDAwLkk2MDRmZGZmOWMwYTdjYmJkZGZkMDI1YTcyZTZmMTlhOTZiYjUxNzUzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f52a91d19918e99e48eed184f5295614623d0518-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTJab-000000007JA-3fAS
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto: drop
 redundant epoch assignments
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
Content-Type: multipart/mixed; boundary="===============6508511693018569952=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6508511693018569952==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zFlf2H+GbYw="; charset=UTF-8

--zFlf2H+GbYw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2190?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: crypto: drop redunda=
nt epoch assignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

crypto: drop redundant epoch assignments

init_key_ctx() already se=
ts ctx->epoch from the key parameters=2E

Change-Id: I604fdff9c0a7cbbddfd02=
5a72e6f19a96bb51753
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
=
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2190
Message-Id: <20261116173725=2E24585-=
1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg41475=2Ehtml
Signed-off-by: Gert Doering <=
gert@greenie=2Emuc=2Ede>
---
M src/openvpn/crypto=2Ec
1 file changed, 0 ins=
ertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/90/2190/2

diff --git a/src/openvpn/crypto=2Ec b/src/o=
penvpn/crypto=2Ec
index 8b4cc3b=2E=2Ea92269d 100644
--- a/src/openvpn/crypt=
o=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1040,7 +1040,6 @@
     snprintf(log_=
prefix, sizeof(log_prefix), "Outgoing %s", name);
     init_key_ctx(ctx, ke=
y_params, kt, OPENVPN_OP_ENCRYPT, log_prefix);
     key_ctx_update_implicit=
_iv(ctx, key_params);
-    ctx->epoch =3D key_params->epoch;
 }
 
 void
@@ =
-1052,7 +1051,6 @@
     snprintf(log_prefix, sizeof(log_prefix), "Incoming =
%s", name);
     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_DECRYPT, log_=
prefix);
     key_ctx_update_implicit_iv(ctx, key_params);
-    ctx->epoch =
=3D key_params->epoch;
 }
 
 void

-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2190?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: I604fdff9c0a7cbbddfd025a72e6f19a96bb51753
Gerrit-Change-=
Number: 2190
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--zFlf2H+GbYw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2190?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">crypto: drop redundant epoch assignments<br><br>init_key_ctx() already =
sets ctx-&gt;epoch from the key parameters=2E<br><br>Change-Id: I604fdff9c0=
a7cbbddfd025a72e6f19a96bb51753<br>Signed-off-by: Razvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2190<br>M=
essage-Id: &lt;20261116173725=2E24585-1-gert@greenie=2Emuc=2Ede&gt;<br>URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg41475=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t;<br>---<br>M src/openvpn/crypto=2Ec<br>1 file changed, 0 insertions(+), 2=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/90/2190/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/c=
rypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 8b4cc3b=2E=2Ea9226=
9d 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ =
b/src/openvpn/crypto=2Ec</span><br><span>@@ -1040,7 +1040,6 @@</span><br><s=
pan>     snprintf(log_prefix, sizeof(log_prefix), &quot;Outgoing %s&quot;, =
name);</span><br><span>     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_EN=
CRYPT, log_prefix);</span><br><span>     key_ctx_update_implicit_iv(ctx, ke=
y_params);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt=
;epoch =3D key_params-&gt;epoch;</span><br><span> }</span><br><span> </span=
><br><span> void</span><br><span>@@ -1052,7 +1051,6 @@</span><br><span>    =
 snprintf(log_prefix, sizeof(log_prefix), &quot;Incoming %s&quot;, name);</=
span><br><span>     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_DECRYPT, l=
og_prefix);</span><br><span>     key_ctx_update_implicit_iv(ctx, key_params=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;epoch =
=3D key_params-&gt;epoch;</span><br><span> }</span><br><span> </span><br><s=
pan> void</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2190?usp=3Demail">change 2190</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2190?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I604fdff9c0a7cbbddfd02=
5a72e6f19a96bb51753 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2190 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>

</body></html>
--zFlf2H+GbYw=--


--===============6508511693018569952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6508511693018569952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6508511693018569952==--

