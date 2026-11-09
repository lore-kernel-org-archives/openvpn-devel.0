Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A16C606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nHBLjzrJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=V/EJSM6D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IBjJfaWm;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ePs3EBKH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V0O+5FTWJ4scTiZzW60mFG6xt+uYPrt6LoJCWrQ9qFE=; b=nHBLjzrJASsq+fEvf5AKIxcxLc
	16OzCIfennx297f9cvb5F+eSeiXEmNzN73FUz2+4cy0UFBvAyvu72wy4Y5rd0qikEU18szuUARQ8X
	INNHUUQNm2XnWcB7GDWQxKxjJcpp1rGO75YzShc9uE2ONcIx4OtWVC8unvWYJJzQY2i8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQJKp-000000003Oz-3uXh;
	Mon, 09 Nov 2026 06:58:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQJKP-000000003Oc-2ky1
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 06:58:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DHOYMDsosSeEwQqvNYEb/ByNbwdTVxEVonN6/BxyM6U=; b=V/EJSM6D3OVxciUCzCpcoAbf6X
 rPIsMxWAmzsWW2ojIghk1/af2sSnIYLUnrCtU8b/g5V1p/s/g59ZncrwKCnMBOsQhn5ZIA06f1vAE
 tmqHIeC+/fbZk8HCg7LtA4TJ6rEb+ajMym8z7WiPooRodUAj5QeTYS5UnkBasPIRst/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DHOYMDsosSeEwQqvNYEb/ByNbwdTVxEVonN6/BxyM6U=; b=IBjJfaWmyMWYMAJTQR2bgeZB5M
 BfOGC5JhlRxJ7f2WbdpwILFgJK6ye9Ofn3p/bTB2/xoEx2y6Hsa9BM1g7TXWnWzeIfxhZ0qru/hot
 dsGsAieVxeQXYFtMPKI1ntdC36TQeDjUTW61Y/H4C5zD3KY3DkF7TXE92nklfwF6NXdw=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQJKN-000000004ft-2Pqd for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 06:58:05 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so366637f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 22:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794207477; x=1794812277; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DHOYMDsosSeEwQqvNYEb/ByNbwdTVxEVonN6/BxyM6U=;
 b=ePs3EBKHZ862ILpCfS4/HcahR92jTXgob/eBCdhNt4zkEmrWXwQ0o2zk3PCHMcqU7H
 avsGNubX1/X2uPzSg290XO6JRp4gt1PqPidejQyfJLlqr48PqijSrLNE9zARUUXlzhuY
 kbyZtw5016BtgGOIse05M0YCYhg6oeuvyRiCTnmDzLoOoHG7+HZs9buwfInIiV8s5V2O
 M1luIztW540Nl680rJZavTh5CBelWW+hGS7bFRtL5x5l8f9R5ZhasZ7G+/6tgU3qC1Zh
 EIc372ES5rZ1q2tIX4BEefwXw0kXv75CTfv2gvP1sHKJlaPPiz/lzPL2KiZRP5REjkep
 b9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794207477; x=1794812277;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DHOYMDsosSeEwQqvNYEb/ByNbwdTVxEVonN6/BxyM6U=;
 b=ZdzwK7g3vHWBiReRrHmDnXKS2z5klc3zUAOYS3jW0YwrNtD/pRcbOzV43jqDVi0+Yc
 0N84qS02iO9d3P/sAbBk+jme0elNiWcShORe9jt0RtIoHgnE+XQkbOKn08osKdiO/idT
 jjUNuBV64gqDujI/4EGNTxmqL1H9MiUHkkJcNXO3XqRIWBasuh42hbtSMEhW1pnvb2aj
 iRgJ/uoL1EDtVJW1kbBUdTpeYgE61zybrFyZYb6qSe9+SpbjR8wTSas6ReFI7l1tNba0
 34VnsMJU7GS/E/z3y0DhuV/4PVcdhle49HuwMlS5k5znyGdv1kbwiTUMha4zOXi0klzE
 E7hg==
X-Gm-Message-State: APuU4Z9MPSfkS0NTmqP10w9lq4gkFeELiBsmN6Uli+iRtpAwqIuIUaQ0
 bJH83Bssl769NonqxOU8DEvbZET/9auFGbZ3YgGB+ECu98RK25DybvSuvQMrhkt+KwYxtDH90p2
 gvq5Ycf4qKLedCqVN1toMTfd0VSR7E33n+MmqumAs/oZh37zTyEhqELghmXUHTbmrLp2E
X-Gm-Gg: AYBFou0WFikBb34ib4R9Zkhbf2gBJeJD7eoQQSJKcUff42FoY6XOw5VhXSZC9j3nhuo
 NfkRnLR7qwfdb9UweLIgbko/lz6gY/ZqhQ0A9Tp86esamQpW+WKmXz21FOPfcqEwT1D2sLyUjfg
 jKN+zgg2/dknizEx1N0R1CQaTIk9mp/aGJ3OHtdEwFxL4WmnHCjX3qOc1rRVFRcNN8yO1Itd6gc
 kOtNJTXTUK7GYk/0sUr/s9q/NRPNonzVHe+8iSBN4AGrMInLIYDElaIYia8PTVpenjp6/hAm/gK
 tCD20H6yj21CUIQJ7z25HLRAAuwATx3hiqYz2k9uPEltJbniw/cPUL97sr6cuo1ofAPECEvRmim
 WfD2kMQbvGFgJSy0ojOfX3o49ueXvzVHDdKVt3rYUCB13b4Hd6l7l2xDPhq/Sw/XLIHahFbUt0H
 L8c1OVUi24saQdBnh5csI+TURoIuErcU4L55Du6bS3qnSiq63Ctf7+o3Wuq2vnxIOZ40JIOg90s
 V3oaXPB7BqQWwGhdDIDCUtKdFgNVg2rWbajp/TUQtcTlKmKgnDyUXbe2fyBNmV6+Ki3mNxth9hw
 fLAaFnnSLvPW+aq8fP4+TUpPeAO34QnHfK6MnhNpamk6EXmRCALH7G/1TGqlj/Fm7Io3BDxkYdt
 gHev+8JNXJ/cMaGjNFo1JsUjZjNnXR6IAAd5hF92tzPRT7b/mhVqYJYn8ZhFCLMP0Ht+NqJJ6Ms
 GhRnqVIFcv6GwUCA==
X-Received: by 2002:a05:6000:41cb:b0:48e:eb:56c5 with SMTP id
 ffacd0b85a97d-4958852d3c4mr6662596f8f.8.1794207476787; 
 Sun, 08 Nov 2026 22:57:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-495966f36besm7417144f8f.14.2026.11.08.22.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 22:57:56 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 06:57:53 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Idb22f731a00158ff020a819081a07e1235d8323d
X-Gerrit-Change-Number: 2156
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2156?usp=email>
X-Gerrit-Commit: 990ade4504db620fa7dccb272635518eb4afa654
In-Reply-To: <gerrit.1794139716000.Idb22f731a00158ff020a819081a07e1235d8323d@gerrit.openvpn.net>
References: <gerrit.1794139716000.Idb22f731a00158ff020a819081a07e1235d8323d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MTM5NzE2MDAwLklkYjIyZjczMWEwMDE1OGZmMDIwYTgxOTA4MWEwN2UxMjM1ZDgzMjNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ef3815453ec4402b9335cb7e2045055ec4d7e919-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQJKN-000000004ft-2Pqd
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: clear
 the context, not the pointer, in ovpn_dco_uninit_net...
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8716286313155192083=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8716286313155192083==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zAO0Zik21SI="; charset=UTF-8

--zAO0Zik21SI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Alexandre Laroche=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
156?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by Antonio Quartulli, Code-Review+2 by Arne Schwabe


Change s=
ubject: dco_linux: clear the context, not the pointer, in ovpn_dco_uninit_n=
etlink()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_=
linux: clear the context, not the pointer, in ovpn_dco_uninit_netlink()

CL=
EAR(dco) zeroes the local pointer variable instead of the
dco_context_t it =
points to, so the context keeps the nl_cb and
nl_cb_notify pointers that we=
re just released with nl_cb_put()=2E

No functional change today, since clo=
se_tun() frees the tuntap right
after, but use CLEAR(*dco) as intended=2E

=
GitHub: closes OpenVPN/openvpn#1143

Assisted-by: Claude Code:claude-opus-5=
-5
Change-Id: Idb22f731a00158ff020a819081a07e1235d8323d
Signed-off-by: Alex=
andre Laroche <larochealexandre@hotmail=2Ecom>
Acked-by: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2156
Message-Id: <20261108122630=2E10223-1-gert@greenie=2Emuc=2Ede>
URL=
: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/=
msg40903=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M=
 src/openvpn/dco_linux=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)


=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/2156/=
2

diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index=
 4412ad0=2E=2Ea84e310 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/open=
vpn/dco_linux=2Ec
@@ -537,7 +537,7 @@
     nl_cb_put(dco->nl_cb);
     nl_c=
b_put(dco->nl_cb_notify);
 
-    CLEAR(dco);
+    CLEAR(*dco);
 }
 
 int

-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb22f731a00158=
ff020a819081a07e1235d8323d
Gerrit-Change-Number: 2156
Gerrit-PatchSet: 2
Ge=
rrit-Owner: Alexandre Laroche
Gerrit-Reviewer: Antonio Quartulli <antonio@m=
andelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--zAO0Zik21SI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Alex=
andre Laroche=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2156?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by Antonio Quartulli, Code-Review+2 by =
Arne Schwabe</p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dco_linux: clear the context, not the pointer=
, in ovpn_dco_uninit_netlink()<br><br>CLEAR(dco) zeroes the local pointer v=
ariable instead of the<br>dco_context_t it points to, so the context keeps =
the nl_cb and<br>nl_cb_notify pointers that were just released with nl_cb_p=
ut()=2E<br><br>No functional change today, since close_tun() frees the tunt=
ap right<br>after, but use CLEAR(*dco) as intended=2E<br><br>GitHub: closes=
 OpenVPN/openvpn#1143<br><br>Assisted-by: Claude Code:claude-opus-5-5<br>Ch=
ange-Id: Idb22f731a00158ff020a819081a07e1235d8323d<br>Signed-off-by: Alexan=
dre Laroche &lt;larochealexandre@hotmail=2Ecom&gt;<br>Acked-by: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2156<br>Message-Id: &lt;20261108122630=2E10223-1-gert@g=
reenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg40903=2Ehtml<br>Signed-off-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dco_linux=2Ec<br>1 =
file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/2156/2</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</spa=
n><br><span>index 4412ad0=2E=2Ea84e310 100644</span><br><span>--- a/src/ope=
nvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><b=
r><span>@@ -537,7 +537,7 @@</span><br><span>     nl_cb_put(dco-&gt;nl_cb);<=
/span><br><span>     nl_cb_put(dco-&gt;nl_cb_notify);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(dco);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*dco);</span><br><s=
pan> }</span><br><span> </span><br><span> int</span><br></pre><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Demail=
">change 2156</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
156?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Idb22f731a00158ff020a819081a07e1235d8323d </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2156 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Alexandre Laroche </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ant=
onio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--zAO0Zik21SI=--


--===============8716286313155192083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8716286313155192083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8716286313155192083==--

