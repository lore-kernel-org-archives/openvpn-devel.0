Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F70606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=h5qhzv65;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mgewP/DO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bA0b1um4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RbHgYIAx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Ewas8o99CIJpqQ1goAzm0dsLZ+d3qxmeBPU12/ijWjE=; b=h5qhzv65s5PB1b+RwCK9K4CV3n
	aA+vAsp+5C2gbk5nufhb2tTwsoBw1sJCMbOaesvI8AAYnDdQFeDpJI9SlCU/YRG3ze8gOal1zkBow
	tp8nxfmE15nRdMXFbQpdQoz+Cibn9mg2WQl0NvLBGuQNXXs57ohEatstdwzuKTwmc0OQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTEVs-000000004ff-0mia;
	Tue, 17 Nov 2026 08:26:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTEVq-000000004fP-2ofy
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:25:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aZVl8nARQ2O88sc9Szf+/i/Gnl3iW+vHgc3o2ggqZiU=; b=mgewP/DOKMCMJO7mMQjU1gIbOH
 qYsufznSAc1O5kuGhFs4AYSDOnPL8OeOpFlVOngnx4EZA244EUGeXKpo+yjmwiLycWGEv9Wx81Uxk
 dS3y4cr6PJ5t5F1nvDA12GsKZpDNBDh02C/IdzAYNiL1jJ7a95N8ly6YGSJrz52s0BBY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aZVl8nARQ2O88sc9Szf+/i/Gnl3iW+vHgc3o2ggqZiU=; b=bA0b1um4ViP6du319XbLfWS0DU
 jL80VfzQReM/4iXf7TGaX4FTPKbky8eY6P5xHmSLhGHAi23UULd+LcTFzuBT0DsJ4Wd6sRonOITwN
 My1w7GwDqO/f7K3/uYmoGHPyCxMiMhluLS3oTfeYu5i1Kbi04Drn6cVQsLe4gmuhcfn0=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTEVq-000000001Dm-0Lmy for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:25:58 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so51931635e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 00:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794903951; x=1795508751; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aZVl8nARQ2O88sc9Szf+/i/Gnl3iW+vHgc3o2ggqZiU=;
 b=RbHgYIAxfX1upu95b5EBPTnBjfuG1Pvz9/7w8Jbd4jzSWf/c3kI45je0/dd4UGT95r
 MazTjlTRpAS7d4N5Ll7K8ig0OgyZOqBefuzdJv2bq71/sTmyo7hTfYaXQxg0FqDGMIjx
 R+yT0f0PsdBYnSWH5vPQU9HTgjEqZM9p9F5217b8Oqldh1yG++o7Yhpnju1zbWqGnQas
 14jPpjgMkWcEG3mkCBXLbhWFY2AKUbgjQ7wdhfX4bSBuH8eoYmnx3fl/2shTppxf/ZVy
 TOERNB30cBV/AEFTSKAcM7G6g9ipMAkTd+MIA0zDeMZ/hvldwC8nrwGt2VBsCJZooLvD
 D5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794903951; x=1795508751;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aZVl8nARQ2O88sc9Szf+/i/Gnl3iW+vHgc3o2ggqZiU=;
 b=p2S3YM55UKYLXqWuyKi17BHK3heTFSoNy0qUg3E8ctyoUe9bKP0r+VQsyTIC+Xp23F
 7yfPHKeMMIo/BNLNCq9NTUEhoJtpMtn+08LkMAXtdVFe0ZcHQDoaLA9j1afQvfYv81gs
 kuk0rORkbwqRKzGHiOzmp4vjWpRK9ZSdCyETvuL8G6dj3Y7lgDFILMTs4jE3T5nrh6em
 dnUVECUfosxxk5I5gpk2B+R1X34Hkg/KTeJamXkQtWFRbazX1vPZyGi3G/M604QzVzvB
 G/QaStWqtOctqBgI4ICf3vP99xW7FSTj8Ch5LTwVbnW2UM8djwqdPcRx3vct76u+gjwa
 qOEA==
X-Gm-Message-State: APuU4Z8uIlvT6778WTiO+q843TTQQzNx2jKpPKX1XAv4Fgy8RszMLT2J
 5Anx4mXeLTJpyJFXf83eBe7Pv9KyZGPPT1BZFqb+2e6nmlE7uT1eXBrXH9ctGB7gyjdbmxtyO4X
 A0tA3qeXSfb4vdLibqFkqyhOs3RQki1lSowyo/Id4vQRcP1T7QeQA9EtVh5L23nUjgm/y
X-Gm-Gg: AYBFou2aQQ2FfY2p/6+3TpPL1ikWdW/IFV6+6i7XQDmszhrMq0adBmaUDFZAcJq53RM
 XhpmmuA0MRra+XUCKr77boexxdmID9VUDgBmrt3Y7+u+GOVAWo0j7WbpHJ9UTqbXG4sKE4dd7M8
 /2SBU7qlz7EwGx9BziRrcbXKhxTK/zpE/DYoe3SiIf4E5Opt9Rgv02LRHt2HMbfq0aJvz+a05y8
 TY3+gv0ymPylrPseFAcvXnuWQHtZoom3fXETjgiqqwtBgsxQfToc6itPBNBQUq3Yma6L/cDPdso
 W1SxISGqHAYUwNsezhMougYnPhfmYDFVSoW+x6inqVYwkup8DNUMz9OK7wTmRz2jyu23RugD2Fx
 1LadbVkx9b59fmGbF6qjNyryxg6SrDSHg4g5f6k5pqzlJWxX9r4iZ4mY2Ke0gPKkl64o9y0JzYq
 U3Rtv2fDGvKO8xauzVrhpG28udCsvFg3Vucdx8/YaeV5AhOtqzoroJ1qqdYGq9jAfSzIGlGb5Xu
 M3u2F6APE8vVkvARSDFOuDMiN7M8pPFNgcPKRT7fxGllxeaW6h7DVn/e1KlZou4NKj2i0/PzS+n
 T/DiDFY4a2jSjPhXl3mv1I7FH6nRFuAbfYjrudFUrGl/FNrqGkv2FdXMHOK20ursivAmSgozL2i
 knIySFDaXCJNPjWUhAjFi66Rl38TpATHTPqaza3taISRZ/FTAfV6fPLXswEuhyFQaPtCzTDUl9J
 Daam/afDdWQfG45XsYqd3eTFOZbE15Rc0a1h4x
X-Received: by 2002:a05:600c:4ecd:b0:4a2:1655:87db with SMTP id
 5b1f17b1804b1-4bb5599d31bmr283877885e9.0.1794903951417; 
 Tue, 17 Nov 2026 00:25:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c603f4e2esm26295059f8f.36.2026.11.17.00.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 00:25:51 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 08:25:50 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4c6bc877c442b24b918fbda2dcc8003127483bfd
X-Gerrit-Change-Number: 2207
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2207?usp=email>
X-Gerrit-Commit: e38117e91353aa30c2714efa36a5e9e639b9803b
References: <gerrit.1794903949000.I4c6bc877c442b24b918fbda2dcc8003127483bfd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTAzOTQ5MDAwLkk0YzZiYzg3N2M0NDJiMjRiOTE4ZmJkYTJkY2M4MDAzMTI3NDgzYmZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ebc05bfb676b9324d8d0a7520c431d8487ae0652-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTEVq-000000001Dm-0Lmy
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socks: accept RFC
 1929 version in username/password auth reply
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
Content-Type: multipart/mixed; boundary="===============5395881311200226516=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5395881311200226516==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X/NcRs84JD4="; charset=UTF-8

--X/NcRs84JD4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2207?usp=3Demail

to review the following change=2E
=


Change subject: socks: accept RFC 1929 version in username/password auth =
reply
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socks: =
accept RFC 1929 version in username/password auth reply

Since d104917e the=
 auth reply must carry VER 5, but RFC 1929 servers
reply with VER 1, so aut=
hentication against them always failed=2E Accept
VER 1, and keep accepting =
5, which some servers send=2E

Change-Id: I4c6bc877c442b24b918fbda2dcc80031=
27483bfd
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/o=
penvpn/socks=2Ec
1 file changed, 3 insertions(+), 2 deletions(-)



  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/07/2207/1

diff=
 --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec
index 51e3a1e=2E=2E6=
cf2715 100644
--- a/src/openvpn/socks=2Ec
+++ b/src/openvpn/socks=2Ec
@@ -1=
38,8 +138,9 @@
         buf[len++] =3D c;
     }
 
-    /* VER =3D 5, SUCCE=
SS =3D 0 --> auth success */
-    if (buf[0] !=3D 5 || buf[1] !=3D 0)
+    =
/* RFC 1929: VER =3D 1, STATUS =3D 0 --> auth success=2E Also accept VER =
=3D 5,
+     * which some servers send=2E */
+    if ((buf[0] !=3D 1 && buf=
[0] !=3D 5) || buf[1] !=3D 0)
     {
         msg(D_LINK_ERRORS, "socks_use=
rname_password_auth: server refused the authentication");
         goto cle=
anup;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2207?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4c6bc877c4=
42b24b918fbda2dcc8003127483bfd
Gerrit-Change-Number: 2207
Gerrit-PatchSet: =
1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>

--X/NcRs84JD4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2207?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">socks: accept RFC 1929 version in username/password aut=
h reply<br><br>Since d104917e the auth reply must carry VER 5, but RFC 1929=
 servers<br>reply with VER 1, so authentication against them always failed=
=2E Accept<br>VER 1, and keep accepting 5, which some servers send=2E<br><b=
r>Change-Id: I4c6bc877c442b24b918fbda2dcc8003127483bfd<br>Signed-off-by: Ra=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/socks=
=2Ec<br>1 file changed, 3 insertions(+), 2 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/07=
/2207/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec<=
/span><br><span>index 51e3a1e=2E=2E6cf2715 100644</span><br><span>--- a/src=
/openvpn/socks=2Ec</span><br><span>+++ b/src/openvpn/socks=2Ec</span><br><s=
pan>@@ -138,8 +138,9 @@</span><br><span>         buf[len++] =3D c;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* VER =3D 5, SUCCESS =3D 0 --&gt; auth success */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf[0] !=3D 5 || buf[1]=
 !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* RFC =
1929: VER =3D 1, STATUS =3D 0 --&gt; auth success=2E Also accept VER =3D 5,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * which some s=
ervers send=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if ((buf[0] !=3D 1 &amp;&amp; buf[0] !=3D 5) || buf[1] !=3D 0)</span><br>=
<span>     {</span><br><span>         msg(D_LINK_ERRORS, &quot;socks_userna=
me_password_auth: server refused the authentication&quot;);</span><br><span=
>         goto cleanup;</span><br></pre><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2207?usp=3Demail">change 2207</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2207?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4c6bc877c=
442b24b918fbda2dcc8003127483bfd </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 2207 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 =
</div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--X/NcRs84JD4=--


--===============5395881311200226516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5395881311200226516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5395881311200226516==--

