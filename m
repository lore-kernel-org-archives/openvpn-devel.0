Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228BEC624A5
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A5Q/1uA2uaLzqkQiTk/vJDOTFpesmHGYnjTTCMN/O9I=; b=Tyb8ObsqQ+Ab8NYoCfFtDrZe7P
	uJ6cpxvoQsVrHYfa0/Svo98REtxlb1PBRveFZ1Vr/qFDe9LGEvC+AGvKt9fMgP+kZkybEcQg151QG
	ci8W2rFasMPamiK8gfK22bJmP33CUqTWLiYifoLbW6Sy09em6NoAdIC64PuxP7pLeCNs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0voA-0003XM-20;
	Mon, 31 Aug 2026 06:47:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0vo8-0003XB-8G
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 06:47:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wX6ZJ6QwCinYiCajjPRm86DqCLhSvvUj9j2x2qmzWeo=; b=QAtS1XP4D2sV/J+2JCkIpcASi6
 lcKN4q4bJCJ3g4RnvrNm5yRCTTEOpCxN+M4NfZWUmRAk0RFF4JmR0PtV2Rh7mgu0Stbapk3te4R1S
 Li1QVQARMWCWAoVzAiIUDi8EWdsQYCtxmXPVtsSmz3TkTGkSZK9ZbVlLTgMZNM9sAztE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wX6ZJ6QwCinYiCajjPRm86DqCLhSvvUj9j2x2qmzWeo=; b=d
 USaUzGzNs6uVCFysNcoQS9FcPR5cRCRN5zGtdw7Bx8XOjmp5bN/fem/H+6TFeiloyLNuAhieHEF2J
 gZSPd96HYU8jjoV8o78s63ARWADkCFSvPlVU/A/1gGz9EI7vLOMIPyXTU208zKFBU8jYzUtltugBy
 w/Pzrrf6oZKErNNI=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0vo4-000895-Ff for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 06:47:49 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49557167508so32636295e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 23:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788158862; x=1788763662; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wX6ZJ6QwCinYiCajjPRm86DqCLhSvvUj9j2x2qmzWeo=;
 b=f5gZOsyvmkSibRWVKdlTmjbOBbcxh4VV4hJif/aJZHT8ngHwWTuM+OP3FxCm70Q/8T
 Bc6ZADTgVdmgQeBKFou+NNnlkkWV+pZnnxiHX5CWp6vy+8Di0OlHxU3jhsKoO6W/OzLX
 yXnIITLM9fscEgcbLaEqm08R5/OG5EMN9QoHk0YTieye4xZWbInnuJI65f2K8wAgl+nE
 cQor0J3eMVghx9qv/LCrrbC+1j04aKEFna+4jinz/bp2NR7rfu20Dy6TSLA1nMOe6Vro
 y4pebpwESut3b7Kh+RbXJWBtEQLJpDKxcHsWPyz3AHDk0f1r+lILR6DgA27qu2RYJe8U
 uR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788158862; x=1788763662;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wX6ZJ6QwCinYiCajjPRm86DqCLhSvvUj9j2x2qmzWeo=;
 b=aBXj+3N8gasIAPqELclFGuZbkXWEVee4sFvOLAMYp05MEjCrMP0d7RFcudz6DQttlF
 69Z248WPdxe9I3a5wld8Yh20oCtPR/O/eBokthj5LIaocJn6XHNY/r1EkxvYW89X/Iw+
 l60HVrXGWViqhy4hhubadngmNdacfmpzZcF0ViBdhrp/wGIz/7eqUSMJ6mu6syeg1TPK
 4mCnuESZj1POP6Cp6rVHU7A7HH8gvRd+7o9012ixY1lmaPzGiulaME2CWbJa/R6HDfih
 sfas4ZSzqlA9A5jIyy2uEzvrHSJwkWtsjKAKVcWQf/QzBQNMg9Afzt3eJaYPyOlE8Pag
 FQRA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4Gn0Qn3f3XITU4D1nJz5wwso8kHAs/bx7WvkPaoW1Oz9r+LGpe0DGn8otyOG5ZkiZEfvbn7M1t7qTI0tG@lists.sourceforge.net
X-Gm-Message-State: AFuF++lpots/miWmod9xbLxK/A/ju85Y7EwAvNbNBcAxxlUUuPqazdUX
 rtMiGRfCas+vCnLqrnFC0WAVfcAheoFcaqi0Xui9HkOIDViCs8un+dqa2J3R87JLUSV2YvFcNtS
 FAawuyLOZNzulggXT22ooU/HZfatiKveC9fpX14lJBsygV5P/6t3UFF3UfkWzRuGPulWv
X-Gm-Gg: AR+sD12W1oKjfCMK2ePodTyBIEpVLLGFra51V5oqVWGQp2YV9vgElPPmULpeoTwSJ9j
 6q43TbbBP163bk7K5j7qRBYcrkAHcDca2O6p1xpaX3qR0n7XVTqY2WqGn4V6fu2gLWtBv9CKrdK
 bwIRcZkxs2YVbBwyDUcyvPqmwUQpQBRjFgNf8IWm0yMCUCqRqOM7XGNKu2SBYDHg+KGw3DNiTYS
 n1txCJJAzBcPACWOyMIcguxT/8YnK0QV4G/Dx1FJIj+4ABJ7jZKAuRrIslB2ej/qQnc89EGd/6T
 EubkL8fcAGvWM8fVosErI2W6YJQsNoSsBwW/FuDlHe0yOZT8gxtSd1zeHKkYa4OS8++2esZtKxc
 xdvumnecWOWE2XWAsmUfJJoqVNFvDyyhNGK0g7+c6AEHOyvF8N8ImMPYkxwgCnhxbFjUz6vTY4u
 q17kg73XEZPHzovS0llLxFjlPqywsUlV1xJoQ5MBoaXcjNRGpr3xhyko2dxiwLlPTnMAdBEK7Uo
 atKmsjID8RQmlc/KFQH1iz/EpNBePKxWyhKqX+EYzPJduoQB3iBCUQt7AeEtjJVO4w57KZGrjj0
 oWXK0kESuIzPk64A7+541KK/tr6qxSt2z7n3EGrPKTnM3LEXdc4=
X-Received: by 2002:a05:600c:190a:b0:49b:8f01:7119 with SMTP id
 5b1f17b1804b1-49cd94e8441mr13232935e9.14.1788158861818; 
 Sun, 30 Aug 2026 23:47:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95013d06sm363237205e9.12.2026.08.30.23.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 23:47:41 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 06:47:41 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ica5d43989b441d4377a3908f811a2953b7a9d45a
X-Gerrit-Change-Number: 1883
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1883?usp=email>
X-Gerrit-Commit: 927b18dff00a8ec0e9233a9689569e4519fc7de6
In-Reply-To: <gerrit.1788113537000.Ica5d43989b441d4377a3908f811a2953b7a9d45a@gerrit.openvpn.net>
References: <gerrit.1788113537000.Ica5d43989b441d4377a3908f811a2953b7a9d45a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTEzNTM3MDAwLkljYTVkNDM5ODliNDQxZDQzNzdhMzkwOGY4MTFhMjk1M2I3YTlkNDVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3cf5de835d0e0224bc6fe344a154e2e72e31b330-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0vo4-000895-Ff
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: openvpnserv:
 detect sibling dirs in CheckConfigPath
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0505782426849460362=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0505782426849460362==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uP3DxsZ9/04="; charset=UTF-8

--uP3DxsZ9/04=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1883?usp=3Demail )

Change subject: openvpnserv: detect sibling dirs in=
 CheckConfigPath
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

openvpnserv: detect sibling dirs in CheckConfigPath

If the config_dir=
 value in the registry has no trailing backslash the
check doesn't actually=
 guarantee that a file is located within
config_dir, because a sibling dir =
with the same prefix, e=2Eg=2E 'config'
and 'config-evil' will match and pr=
oduce a positive verdict=2E

By also checking that there is a path separato=
r after config_dir
prevents this attack=2E

Reported-By: Harshit Varu <hars=
hitvaru666@gmail=2Ecom>
Tested-By: Harshit Varu <harshitvaru666@gmail=2Ecom=
>
CVE: 2026-81830
Github: OpenVPN/openvpn-private-issues#166
Change-Id: Ica=
5d43989b441d4377a3908f811a2953b7a9d45a
Signed-off-by: Heiko Hund <heiko@ist=
=2Eeigentlich=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acke=
d-by: Arne Schwabe <arne@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1883
Message-Id: <20260830182134=2E32251-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38828=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpnserv/validate=2Ec
1 file changed, 14 insertio=
ns(+), 3 deletions(-)




diff --git a/src/openvpnserv/validate=2Ec b/src/o=
penvpnserv/validate=2Ec
index 770a7a0=2E=2Eb0fb6b85 100644
--- a/src/openvp=
nserv/validate=2Ec
+++ b/src/openvpnserv/validate=2Ec
@@ -56,7 +56,9 @@
 
 =
/*
  * Check workdir\fname is inside config_dir
- * The logic here is simpl=
e: we may reject some valid paths if =2E=2E\ is in any of the strings
+ * T=
he logic here is simple:
+ *      we may reject some valid paths if "=2E=2E=
" is in the filename
+ *      or if there's no "\" after the config directo=
ry
  */
 static BOOL
 CheckConfigPath(const WCHAR *workdir, const WCHAR *fn=
ame, const settings_t *s)
@@ -82,9 +84,18 @@
     }
 
     config_dir =3D s=
->config_dir;
+    size_t config_dir_len =3D wcslen(config_dir);
 
-    if =
(wcsncmp(config_dir, config_file, wcslen(config_dir)) =3D=3D 0
-        && =
wcsstr(config_file + wcslen(config_dir), L"=2E=2E") =3D=3D NULL)
+    /* ch=
eck for a path separator after config_dir */
+    if (config_dir_len && con=
fig_dir_len < wcslen(config_file)
+        && config_dir[config_dir_len - 1=
] !=3D L'\\'
+        && config_file[config_dir_len] !=3D L'\\')
+    {
+  =
      return FALSE;
+    }
+
+    if (wcsncmp(config_dir, config_file, conf=
ig_dir_len) =3D=3D 0
+        && wcsstr(config_file + config_dir_len, L"=2E=
=2E") =3D=3D NULL)
     {
         return TRUE;
     }

-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1883?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-=
Branch: release/2=2E6
Gerrit-Change-Id: Ica5d43989b441d4377a3908f811a2953b7=
a9d45a
Gerrit-Change-Number: 1883
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <g=
ert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: d12fk <hei=
ko@openvpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>

--uP3DxsZ9/04=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1883?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">openvpnserv: detect sibling dirs in CheckC=
onfigPath<br><br>If the config_dir value in the registry has no trailing ba=
ckslash the<br>check doesn&#39;t actually guarantee that a file is located =
within<br>config_dir, because a sibling dir with the same prefix, e=2Eg=2E =
&#39;config&#39;<br>and &#39;config-evil&#39; will match and produce a posi=
tive verdict=2E<br><br>By also checking that there is a path separator afte=
r config_dir<br>prevents this attack=2E<br><br>Reported-By: Harshit Varu &l=
t;harshitvaru666@gmail=2Ecom&gt;<br>Tested-By: Harshit Varu &lt;harshitvaru=
666@gmail=2Ecom&gt;<br>CVE: 2026-81830<br>Github: OpenVPN/openvpn-private-i=
ssues#166<br>Change-Id: Ica5d43989b441d4377a3908f811a2953b7a9d45a<br>Signed=
-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Razva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne=
@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1883<br>Message-Id: &lt;20260830182134=2E32251-1-gert@greenie=2Emuc=2Ede&=
gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg38828=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/validate=2Ec<br>1 file changed,=
 14 insertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
serv/validate=2Ec b/src/openvpnserv/validate=2Ec</span><br><span>index 770a=
7a0=2E=2Eb0fb6b85 100644</span><br><span>--- a/src/openvpnserv/validate=2Ec=
</span><br><span>+++ b/src/openvpnserv/validate=2Ec</span><br><span>@@ -56,=
7 +56,9 @@</span><br><span> </span><br><span> /*</span><br><span>  * Check =
workdir\fname is inside config_dir</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * The logic here is simple: we may reject some valid paths if=
 =2E=2E\ is in any of the strings</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * The logic here is simple:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *      we may reject some valid paths if &quot;=2E=
=2E&quot; is in the filename</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *      or if there&#39;s no &quot;\&quot; after the config direct=
ory</span><br><span>  */</span><br><span> static BOOL</span><br><span> Chec=
kConfigPath(const WCHAR *workdir, const WCHAR *fname, const settings_t *s)<=
/span><br><span>@@ -82,9 +84,18 @@</span><br><span>     }</span><br><span> =
</span><br><span>     config_dir =3D s-&gt;config_dir;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    size_t config_dir_len =3D wcslen(con=
fig_dir);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (wcsncmp(config_dir, config_file, wcslen(config_dir)) =3D=3D 0=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; wc=
sstr(config_file + wcslen(config_dir), L&quot;=2E=2E&quot;) =3D=3D NULL)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check for a pat=
h separator after config_dir */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (config_dir_len &amp;&amp; config_dir_len &lt; wcslen(co=
nfig_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &=
amp;&amp; config_dir[config_dir_len - 1] !=3D L&#39;\\&#39;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; config_file[conf=
ig_dir_len] !=3D L&#39;\\&#39;)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (wcsncmp(config_dir, confi=
g_file, config_dir_len) =3D=3D 0</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        &amp;&amp; wcsstr(config_file + config_dir_len, L&quot=
;=2E=2E&quot;) =3D=3D NULL)</span><br><span>     {</span><br><span>        =
 return TRUE;</span><br><span>     }</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1883?usp=
=3Demail">change 1883</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1883?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: Ica5d43989b441d4377a3908f811a2953b7a9d45a </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1883 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@o=
penvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--uP3DxsZ9/04=--


--===============0505782426849460362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0505782426849460362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0505782426849460362==--

