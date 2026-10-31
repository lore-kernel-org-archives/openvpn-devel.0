Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9462C606A322
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z9sWquR5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mW4UwdqE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Hxbyxye6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Xg7cNQY0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cQkSh5eygDAj86Qgvet1JCxWR5D0bv0nnBivvkTbOXo=; b=Z9sWquR5K7Y5D4t8w/PQCZV4hT
	+zU2C5sYfWGE2B04/R68AiTgHU48KVEoxAnT4YC/kJL40xyngX/cXJEk4wItVr9tv/FrDC5Hm2b3F
	IQH5U0W788ALTIOhYzmAA1ys6ZgHg0VDxcYaXIBt9MeS8TjfSgQPvrqGqtEOjiqjYpd4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNBsq-00000000843-1ICU;
	Sat, 31 Oct 2026 16:24:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNBsn-0000000083n-30Rp
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:24:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wDMEoF/JqVkvWFvlq9cnSkK3QgKSBZLQQZGZEXYxkSA=; b=mW4UwdqErRJxgt6A9c7NmePy33
 6Fv9l/u5xjmh3JM5gNXmkLMSRAUrggnVbzmqMVicbauFhoQJseQGkGcZ7PnrDvVgnisHkXNgqdn+o
 Sesl7y9EuQpg4I0DPnTwy+U3gxqnhx5twadvwFgb+B+vvCy4IAaL2XbsvD3TKo1a5XRI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wDMEoF/JqVkvWFvlq9cnSkK3QgKSBZLQQZGZEXYxkSA=; b=Hxbyxye6PbFQW1KHGchJVPSVRW
 LIu5dWxeLcn7P/ekj27lAkKRClsxTjCEBFOejo+v7rSMXy1ACLy5eAYiuGuX5AQvGNBcd900YbalU
 BIWRVohkGerPKmAoD9+IBeAjLI98ZUS51fxyTzwBkicZmJEtIPigNggJd6Jf1Ktct134=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNBsZ-000000003ph-1sWN for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:24:28 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so13728115e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 09:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793463861; x=1794068661; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wDMEoF/JqVkvWFvlq9cnSkK3QgKSBZLQQZGZEXYxkSA=;
 b=Xg7cNQY01xt80w2EBt4c8r+4bbnLhAc+KQ/QXIBxsMDThuJAOC/i1xdkw6bOlPhN+p
 2L8SW63Ud6e2ApBeEamG/nEfD3NzzSJMqfJripJiaRMtYT7pbq07FKUoQnTB/Vz9FGFb
 1Qz6QkaFFA2cwqDMtnb7k3qiWA00DVyt0w5Qa3sNRnfQgQif7myOB+l4DI/c3hQpEKEl
 x3nuDndGq/m0pmBptymTIrJeDpOz5n5LTdqcRJgkg+7q5Vz5NeE90ldfKxfHJkVxt41L
 cD95lQ/YF6F17WGkIXDst/Ou5woNl7F+wdlbUtNXhwOh/ExU2xH3y3tHHm1D808gHcvf
 7zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793463861; x=1794068661;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wDMEoF/JqVkvWFvlq9cnSkK3QgKSBZLQQZGZEXYxkSA=;
 b=ljeGHP6QBxeeeY1UxKmFNRd9l6AoAhxIFEC2j4MOnTZ5fZVog6ZFWKvDZRi5+5w3h2
 4R9Ebdhr2iSMJJCgWMKKjNtZ81wIalw3wfNOpdqiNauVZYF0d6Zfb+4F96RdIP37AFTd
 c3fgZgloAWZBlEEGs5bZI8H5qinFdFdvOGoRolpGuAj4MDhv4RMBMYzHTPmny3uKNYqy
 6CWE453vpQudpqzy5wR7CdpxK5mOmiy1BWV4+wbdbznVOzwlTsRdr14p5qolM/Vb3068
 wtWfcUZoABXhqo4ReEJ4JTxT48gn7acfWEHSNcgoefQeScEbBr3NxGV2PCOdbxrggtyU
 LQ5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJ0z84WsWZG4HKa8WVZJe/kgOPokHPNlGIZb8NcggqX80WsR3wBjc4QnYbHCNejTsJoCZVf/9JZBY1pjDm@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJbpwYC5MmEvKGs3exr9xXcb+ks5kfpS7zyi446A/UHj4C26gXU
 XggbZjF9eCnXtUq1ZFw6Kgp2O2mMSpIAjhi89do9oaDD3uFmAezOWc7I4mbLyNkHH/8ttpLX1Rn
 N9KTnCeX2IFez3X50r6WOmG7ttVYhHCgkPOPucA+ueoeXSyTYhQqADRwOirGzhCMRWpgQ
X-Gm-Gg: AYBFou2O5t0rHHcqhk8V0Lf+dFjDZbl6DL0OEwCubTmsaQMdFs2Ojo6uv65hIPGfJrY
 LPb7aZrPXUliw4Js1v5MSCY1/GgRApuNYmGNHx/CrQkBut6etNMK0blvpfj6mTYElNrL5+gC31J
 ktuU36rgMomx0EajhExqDTKxvoiwNehXiCHBC20h7BgUo1BNjKbxgHZewaEvbAsADNq5kMm0dhc
 bMSiPmgBlmY2sOfKN8mXeChfDxN3mHL2ExAirKEtwSuab6u47SQvVcOqSxE75elkPVwmGgAJAB9
 EKbfjZDanZCA9X7sip1QsldbvtJ4RCvxmr60HHnWm2ib2nRQkp1yjvDJqJtdSLtLZQhGJjB/hUv
 l3iW93OfXWrMR8sraR3xppdR9IdbctBVnGmZ3RoCW8ToHQdTfQ1YbarXHSbSGMM/mRNsRu4gOPd
 63wHLxeNgnyGARtCqoN2kY1BeLs3Wt2++S4ALGys4NkoPmHrp7pFYTfsjf01bH8sbPYBArFbE08
 Wt58RzmP0odWS4teOKCaz45tJHLxQ7f4IuHf7PjSgc/psq3hUe+H3co82YiWluAhfNs018ml06P
 O+R1edj0+P1sVMtnRWuBdD3ijPkA3EaUSKYcogzUC2GphK04yVF5UB6lMu0oexefwU8od2KUX9L
 jQ3ItihLUT7brdIT7iFFJJ4j0pwXjEeSmetxyUOnzfZ39Df6Be+Iwa++I1jdJWph7c10fLRNw5j
 3ERSrELd/aUyVUv2JK99/Lngfj6AidfzWQ63A75w==
X-Received: by 2002:a05:600c:4454:b0:4a3:5a7b:6002 with SMTP id
 5b1f17b1804b1-4ac17d19777mr122806045e9.28.1793463860702; 
 Sat, 31 Oct 2026 09:24:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6c76507sm146524375e9.10.2026.10.31.09.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:24:20 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 16:24:20 +0000
To: Selva Nair <selva.nair@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I464672facb34de83930eddc4e86826d3b1cd3edd
X-Gerrit-Change-Number: 2068
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2068?usp=email>
X-Gerrit-Commit: 0975c6e707fe742aaddf02049d70942bb04676a0
In-Reply-To: <gerrit.1793212962000.I464672facb34de83930eddc4e86826d3b1cd3edd@gerrit.openvpn.net>
References: <gerrit.1793212962000.I464672facb34de83930eddc4e86826d3b1cd3edd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLkk0NjQ2NzJmYWNiMzRkZTgzOTMwZWRkYzRlODY4MjZkM2IxY2QzZWRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3d2463fb310c3603cc53e74d36b7715287038141-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNBsZ-000000003ph-1sWN
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix numbering of
 examples in management-notes.txt
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5859348132220992650=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5859348132220992650==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="N+sdwWWv2Yo="; charset=UTF-8

--N+sdwWWv2Yo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2068?usp=3Demail )

Change subject: Fix numbering of examples i=
n management-notes=2Etxt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Fix numbering of examples in management-notes=2Etxt

Change-I=
d: I464672facb34de83930eddc4e86826d3b1cd3edd
Signed-off-by: Selva Nair <sel=
va=2Enair@gmail=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2068
Message-Id: <20=
261028201609=2E13684-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40270=2Ehtml
Signed-o=
ff-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M doc/management-notes=2E=
txt
1 file changed, 7 insertions(+), 7 deletions(-)




diff --git a/doc/ma=
nagement-notes=2Etxt b/doc/management-notes=2Etxt
index a28a1a8=2E=2Eeac91a=
4 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
=
@@ -345,29 +345,29 @@
   The PASSWORD real-time message type can also be us=
ed to
   indicate password or other types of authentication failure:
 
-  E=
xample 3: The private key password is incorrect and OpenVPN
+  Example 4: T=
he private key password is incorrect and OpenVPN
   is exiting:
 
     >PAS=
SWORD:Verification Failed: 'Private Key'
 
-  Example 4: The --auth-user-pa=
ss username/password failed,
+  Example 5: The --auth-user-pass username/pa=
ssword failed,
   and OpenVPN will exit with a fatal error if '--auth-retry=
 none'
   (which is the default) is in effect:
 
     >PASSWORD:Verificatio=
n Failed: 'Auth'
 
-  Example 5: The --auth-user-pass username/password fai=
led,
+  Example 6: The --auth-user-pass username/password failed,
   and th=
e server provided a custom client-reason-text string
   using the client-de=
ny server-side management interface command=2E
 
     >PASSWORD:Verificatio=
n Failed: 'custom server-generated string'
 
-  Example 6: If server pushes=
 --auth-token to the client, the OpenVPN
+  Example 7: If server pushes --a=
uth-token to the client, the OpenVPN
   will produce a real-time PASSWORD m=
essage:
 
     >PASSWORD:Auth-Token:foobar
 
-  Example 7: Static challenge=
/response:
+  Example 8: Static challenge/response:
 
     >PASSWORD:Need '=
Auth' username/password SC:1,Please enter token PIN
 
@@ -378,7 +378,7 @@
 =
  formatted as described in the Challenge/Response Protocol section
   belo=
w=2E
 
-  Example 8: Dynamic challenge/response:
+  Example 9: Dynamic chal=
lenge/response:
 
     >PASSWORD:Verification Failed: ['CRV1:R,E:Om01u7Fh4L=
rGBS7uh0SWmzwabUiGiW6l:Y3Ix:Please enter token PIN']
 
@@ -395,7 +395,7 @@
=
   in the Challenge/Response Protocol section below
 
 See the "Challenge/R=
esponse Protocol" section below for more details
-about examples 7 and 8, i=
ncluding how the management interface client
+about examples 8 and 9, inclu=
ding how the management interface client
 should respond=2E
 
 COMMAND -- f=
orget-passwords

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2068?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I464=
672facb34de83930eddc4e86826d3b1cd3edd
Gerrit-Change-Number: 2068
Gerrit-Pat=
chSet: 2
Gerrit-Owner: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--N+sdwWWv2Yo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2068?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Fix numbering of examples in manag=
ement-notes=2Etxt<br><br>Change-Id: I464672facb34de83930eddc4e86826d3b1cd3e=
dd<br>Signed-off-by: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt;<br>Acked-b=
y: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2068<br>Message-Id: &lt;20261028201609=2E=
13684-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg40270=2Ehtml<br>Signed-off-by:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M doc/management-no=
tes=2Etxt<br>1 file changed, 7 insertions(+), 7 deletions(-)<br><br></pre>
=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</sp=
an><br><span>index a28a1a8=2E=2Eeac91a4 100644</span><br><span>--- a/doc/ma=
nagement-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</span=
><br><span>@@ -345,29 +345,29 @@</span><br><span>   The PASSWORD real-time =
message type can also be used to</span><br><span>   indicate password or ot=
her types of authentication failure:</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  Example 3: The private key password is i=
ncorrect and OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  Example 4: The private key password is incorrect and OpenVPN</span><br><=
span>   is exiting:</span><br><span> </span><br><span>     &gt;PASSWORD:Ver=
ification Failed: &#39;Private Key&#39;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  Example 4: The --auth-user-pass usern=
ame/password failed,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  Example 5: The --auth-user-pass username/password failed,</span><br><spa=
n>   and OpenVPN will exit with a fatal error if &#39;--auth-retry none&#39=
;</span><br><span>   (which is the default) is in effect:</span><br><span> =
</span><br><span>     &gt;PASSWORD:Verification Failed: &#39;Auth&#39;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Exampl=
e 5: The --auth-user-pass username/password failed,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Example 6: The --auth-user-pass usernam=
e/password failed,</span><br><span>   and the server provided a custom clie=
nt-reason-text string</span><br><span>   using the client-deny server-side =
management interface command=2E</span><br><span> </span><br><span>     &gt;=
PASSWORD:Verification Failed: &#39;custom server-generated string&#39;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Exampl=
e 6: If server pushes --auth-token to the client, the OpenVPN</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  Example 7: If server pushes --a=
uth-token to the client, the OpenVPN</span><br><span>   will produce a real=
-time PASSWORD message:</span><br><span> </span><br><span>     &gt;PASSWORD=
:Auth-Token:foobar</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  Example 7: Static challenge/response:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  Example 8: Static challenge/response:<=
/span><br><span> </span><br><span>     &gt;PASSWORD:Need &#39;Auth&#39; use=
rname/password SC:1,Please enter token PIN</span><br><span> </span><br><spa=
n>@@ -378,7 +378,7 @@</span><br><span>   formatted as described in the Chal=
lenge/Response Protocol section</span><br><span>   below=2E</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Example 8: Dynami=
c challenge/response:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  Example 9: Dynamic challenge/response:</span><br><span> </span><br><spa=
n>     &gt;PASSWORD:Verification Failed: [&#39;CRV1:R,E:Om01u7Fh4LrGBS7uh0S=
WmzwabUiGiW6l:Y3Ix:Please enter token PIN&#39;]</span><br><span> </span><br=
><span>@@ -395,7 +395,7 @@</span><br><span>   in the Challenge/Response Pro=
tocol section below</span><br><span> </span><br><span> See the &quot;Challe=
nge/Response Protocol&quot; section below for more details</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-about examples 7 and 8, including how =
the management interface client</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+about examples 8 and 9, including how the management interface =
client</span><br><span> should respond=2E</span><br><span> </span><br><span=
> COMMAND -- forget-passwords</span><br></pre><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2068?usp=3Demail">change 2068</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2068?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4646=
72facb34de83930eddc4e86826d3b1cd3edd </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 2068 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Selva Nair &lt;selva=
=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--N+sdwWWv2Yo=--


--===============5859348132220992650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5859348132220992650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5859348132220992650==--

