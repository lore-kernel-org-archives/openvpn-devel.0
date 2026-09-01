Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E25C61DD3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bPD1KaS+hxdVntn9VyWdvd/nFDnHM4NUWsEroSpJv/Q=; b=DFYIrODqjNAYlMRT7jnAjOVfGy
	5/gIRh+pvr/1zArpLvSeAZkPqxcFrbtXZUtNox+PSYxbuWV+OrtkPNcIqwoayAVGNlhYKjGbB4v+8
	p93hlo+YCFGyvZl+G7Z7flJDiuBjbQJmu/3INbW5SihqSAdAmrUna86zVJUyMlqXUDRE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1Nkp-0005Pp-3E;
	Tue, 01 Sep 2026 12:38:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1Nkl-0005PQ-Tc
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:38:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uEB32481KSFKP/ARnYUKjmA/4cxu3Cwju0mhvfmqdnw=; b=MhgXCJPNaUMUHnFIyi6/isqZEr
 S21OXdQm+/DCIJ+lrMMohjZocUZiPvictimE6r5NtZwWK384kl+0LPGE9Z23Q4J6HsbI1WST2geft
 l6iysJVAAgYXwnD7ts8B6HIVyXQSS3sVZMxoJxDdZHSFyAyH1DZwWi71JjLCFgPAOxt8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uEB32481KSFKP/ARnYUKjmA/4cxu3Cwju0mhvfmqdnw=; b=f
 BYSCbpUKBkg0T4/hXV5RwgYOT11l18mlldq+X2XvzX5dSyxDw7CTeA4BdqHCSTh0UI3jXgwV87bG3
 bPq3iK2gyrf5T0ypyejUvk2O6dgE/bNLUUMjudjRxQrot/qR0w/iBkRn3bjlu1HlSfWKf1uFYlmw2
 NVkzpWWzhU+rND68=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1Nkl-0007sC-OS for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:38:16 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-482fc2b44a7so900878f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 05:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788266289; x=1788871089; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uEB32481KSFKP/ARnYUKjmA/4cxu3Cwju0mhvfmqdnw=;
 b=M4Ikk0rMH8Nw6JBRftUMZpiY8sV1AEwPLb/7Gt8VwNALlKpeAuhALw16vpMPA/NRKE
 xaLVgSGupIrzbiyk78SnVCFUapZ7gIAJUd6UL+gpppDiDBhX6hThYcF1dsC2R0vy6HhL
 CwpnYnoXu5D9iJUA10ECr8nNVNPweABtxS6CcjiZRf2aRZq3Pn6KHZZGz21ckYjFCFdd
 +jY1uc08JzRLgRzRM5FnmdtLhFKlUc4Kgyw6yPY1UgEPqffxVs8pmCSP9tOT56gLembp
 xrcxLH+89sUO/2IyEozXrFqJLKuRkgz4vaV2VgGw5rX275+ZNIAbeDCovwltg4NhJHFx
 AkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788266289; x=1788871089;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uEB32481KSFKP/ARnYUKjmA/4cxu3Cwju0mhvfmqdnw=;
 b=Q7OY9eIofVXMNWsWdvZQ/hft9BbZ20ti5zCdOJSsVGJdSKO29XZMApXXiZidvcF+2c
 dBML1womGdlXoyaFlUZ+zpXGoNxHMP5st+AwW4PrDMf53Cvm2x7IcNOAK6eqeSwgI0yz
 67YBuqt3ZdZFlZynFwKLyEZEjfjWmeKXPWCDCsa9ci3f3xt4jM41BgK7poi509LXtgaT
 utbiAM+QKU/vFhZSwP8kPK4OJVko6dTbckPlUOo6vS9PfHOIm4KNPeR6h9nm+nAUMo0W
 l0BZhvBncJ/2DNSTqaoKXlkiDiNGQKHxoI1EEn3hRSDlhOAxcKY8cDTiXu0vLHrut1Qt
 m+Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcqnvCcCM5efI6QJZTV/EXD0fGny1RBpwmt/QLS2oZMPPBpsXYdGqS7ixNkISrPwOTSvI+NUbBRomKIlMF@lists.sourceforge.net
X-Gm-Message-State: AFuF++nxmuS5RtFPGPmr/JFD75i28mb724KVB+XAmnSYJ6MFzDZowjl3
 SE/y3XSeuzoaZwci5zd+/yhka2CJz46V/i5+NUQQ87/dJVgDhz1OAYwDA+Iaj4hoqdT5Yx14AOT
 bv8y1oqgFJDkcpzPBPrDbaSLoaKf1Rg7urtkzlQVIO7+nKn8rlk6LXIdgjWulH6JwaySo
X-Gm-Gg: AYBFou0jdHgZ4A+zXHj5KKGJ1nAx5HHljdTNKBRStVJ1iTbLU02pbE5EKeaMmFGPdgt
 LaPvwSrfRTkG8meqcE/J3qkYUQ/Q6C7ELTw+vpMvmacy1fv3FxvjcnmIOCdsCwQPQVcbsZMVvU6
 /kvrpqfEsxil0h1v0ibYt4UY9BNYp5oAfm/amaJuaAvjllfu7BnA7yy236y0axN+Re/my90ZDoh
 vJpro0TdA6k+8S6tM5VqAaaFCtLoiLeacjdx8JeLSkHPpJYDABiBq3/Xxrkz/yOOeKDzs7q2kFw
 cCgZpope/H+WM2aBhfLGWnAG9JhqFToCAMD3VnM3pmFTNQBouoRClpkNn3/Z28YU+XIhGh3QQI+
 KYvnLPsplg1QdSVurghdeV4OGlpWE9Ww4tMGouAwStpMksuo4zk2ETVhRWG/ALnM/O/QNPvFeIt
 eNZ8f+0ifTxz8foa2SYwkL2FtzPiGxwkwxS8P72MF9sM+et+9VgFbW08tIoBqc8wXFaO7R+ykNE
 eB3MUj3KhDff5Y90BUq+XVpgfrOCP/aw95xkCtnAXPbGCkkzqVxiNEJignQlWvCZqFOdpF6ux54
 G+16sfQMdiONmEUsPUj4nxUVLDtoHn80YlOtT8I+vjhIcZur9yU=
X-Received: by 2002:a05:6000:250c:b0:484:453a:8889 with SMTP id
 ffacd0b85a97d-484453a892bmr6123619f8f.22.1788266288958; 
 Tue, 01 Sep 2026 05:38:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d3d2eesm4636259f8f.15.2026.09.01.05.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 05:38:08 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 12:38:08 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
X-Gerrit-Change-Number: 1886
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1886?usp=email>
X-Gerrit-Commit: 588af513aac1d2d774fd3fde1716384e3501a5a1
In-Reply-To: <gerrit.1788192180000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
References: <gerrit.1788192180000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkljOTgzYTNiZjFlZThkNGVmOThmMzg4M2Q1ZTVkZGYyMzQ2OTZhMTgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d442772b4e62403f03850be50117d436e1d2bc0e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1Nkl-0007sC-OS
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: harden
 CheckConfigPath() a bit more
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
Content-Type: multipart/mixed; boundary="===============1722901041871674285=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1722901041871674285==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8/cjA1wlHEs="; charset=UTF-8

--8/cjA1wlHEs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1886?usp=3Demail )

Change subject: openvpnserv: harden CheckConfigPath=
() a bit more
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


openvpnserv: harden CheckConfigPath() a bit more

If the config_path retr=
ieved from the Registry doesn't end with a path
sepatator, the prefix check=
 could be satisfied by a sibling directory
that starts with the same substr=
ing, e=2Eg=2E "config" vs=2E "configx"=2E While
code in common=2Ec ensures =
this, that code could disappear in the future
leaving the check vulnerable=
=2E Instead spend the few CPU cycles to be
absolutely sure, we're doing the=
 right thing here=2E

Discovered and reported by BreachX Zero Day Labs, usi=
ng Typhon AI Mil v2=2E
Contributing Researcher: Vivek Parikh=2E

Reported-b=
y: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Tested-by: Vivek Parikh <vive=
k=2Eparikh@breachx=2Eai>
CVE: 2026-78043
Change-Id: Ic983a3bf1ee8d4ef98f388=
3d5e5ddf234696a182
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>=

Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Arne Schwabe <=
arne@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1886
Message-Id: <20260831184709=2E3359-1-gert@greenie=2Emuc=2Ede>
URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38=
854=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/=
openvpnserv/validate=2Ec
1 file changed, 7 insertions(+), 1 deletion(-)



=

diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/validate=2Ec
i=
ndex e3ef8b6=2E=2E8e529b9 100644
--- a/src/openvpnserv/validate=2Ec
+++ b/s=
rc/openvpnserv/validate=2Ec
@@ -62,7 +62,13 @@
 {
     HRESULT res;
     WC=
HAR config_path[MAX_PATH];
+    const size_t config_dir_len =3D wcslen(s->c=
onfig_dir);
 
+    /* config_dir must end with a '\' or the prefix check be=
low could be satisfied by a sibling directory */
+    if (config_dir_len =
=3D=3D 0 || s->config_dir[config_dir_len - 1] !=3D L'\\')
+    {
+        r=
eturn FALSE;
+    }
     /* fname =3D stdin is special: do not treat it as =
a relative path */
     if (wcscmp(fname, L"stdin") =3D=3D 0)
     {
@@ -83=
,7 +89,7 @@
         res =3D PathCchCanonicalize(config_path, _countof(conf=
ig_path), fname);
     }
 
-    return res =3D=3D S_OK && wcsnicmp(config_p=
ath, s->config_dir, wcslen(s->config_dir)) =3D=3D 0;
+    return res =3D=3D=
 S_OK && wcsnicmp(config_path, s->config_dir, config_dir_len) =3D=3D 0;
 }
=
 
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1886?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic983a3bf1ee8d4ef=
98f3883d5e5ddf234696a182
Gerrit-Change-Number: 1886
Gerrit-PatchSet: 2
Gerr=
it-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Ger=
rit-CC: d12fk <heiko@openvpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>

--8/cjA1wlHEs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1886?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">openvpnserv: harden CheckConfigPath() a bi=
t more<br><br>If the config_path retrieved from the Registry doesn&#39;t en=
d with a path<br>sepatator, the prefix check could be satisfied by a siblin=
g directory<br>that starts with the same substring, e=2Eg=2E &quot;config&q=
uot; vs=2E &quot;configx&quot;=2E While<br>code in common=2Ec ensures this,=
 that code could disappear in the future<br>leaving the check vulnerable=2E=
 Instead spend the few CPU cycles to be<br>absolutely sure, we&#39;re doing=
 the right thing here=2E<br><br>Discovered and reported by BreachX Zero Day=
 Labs, using Typhon AI Mil v2=2E<br>Contributing Researcher: Vivek Parikh=
=2E<br><br>Reported-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br=
>Tested-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>CVE: 2026-7=
8043<br>Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182<br>Signed-off-=
by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne@rfc2=
549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/188=
6<br>Message-Id: &lt;20260831184709=2E3359-1-gert@greenie=2Emuc=2Ede&gt;<br=
>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg38854=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M src/openvpnserv/validate=2Ec<br>1 file changed, 7 ins=
ertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/val=
idate=2Ec b/src/openvpnserv/validate=2Ec</span><br><span>index e3ef8b6=2E=
=2E8e529b9 100644</span><br><span>--- a/src/openvpnserv/validate=2Ec</span>=
<br><span>+++ b/src/openvpnserv/validate=2Ec</span><br><span>@@ -62,7 +62,1=
3 @@</span><br><span> {</span><br><span>     HRESULT res;</span><br><span> =
    WCHAR config_path[MAX_PATH];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const size_t config_dir_len =3D wcslen(s-&gt;config_dir);<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* config_dir must end with a &#39;\&#39; or the prefix check below could=
 be satisfied by a sibling directory */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (config_dir_len =3D=3D 0 || s-&gt;config_dir[con=
fig_dir_len - 1] !=3D L&#39;\\&#39;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span>     /* fname =3D stdin is special: do not treat=
 it as a relative path */</span><br><span>     if (wcscmp(fname, L&quot;std=
in&quot;) =3D=3D 0)</span><br><span>     {</span><br><span>@@ -83,7 +89,7 @=
@</span><br><span>         res =3D PathCchCanonicalize(config_path, _counto=
f(config_path), fname);</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return res =3D=3D S_OK &amp;=
&amp; wcsnicmp(config_path, s-&gt;config_dir, wcslen(s-&gt;config_dir)) =3D=
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return re=
s =3D=3D S_OK &amp;&amp; wcsnicmp(config_path, s-&gt;config_dir, config_dir=
_len) =3D=3D 0;</span><br><span> }</span><br><span> </span><br><span> </spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1886?usp=3Demail">change 1886</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1886?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f388=
3d5e5ddf234696a182 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1886 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>

</body></html>
--8/cjA1wlHEs=--


--===============1722901041871674285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1722901041871674285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1722901041871674285==--

