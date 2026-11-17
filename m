Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB4606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iFBU8xiO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Mkxx4gmG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f+JpGA/x;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=T4hWnlet
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=scuNNyU9VqCAFk54soGTgmIhURA+ZEEYIZP/NHdR9rE=; b=iFBU8xiOjah9+iQ9r2Au10JzDS
	a/AvdYJCL08dtBOsXxM4s5IQpBwf5rTTHz9hVEn9WfaVBHQavAQMOoeLm1LQcDbWAn86FEKHf3YCF
	xTHfJz3Yx3vBeicHKZ4Z9h43NFhKXsTVnCuiXCNm6jJHHO8DWsr/IW0nZHJgv2aSbsIw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTF9k-000000003RK-0SSt;
	Tue, 17 Nov 2026 09:07:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTF9j-000000003RD-01zq
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 09:07:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AtgC9lgCiOGZOonyFaIqeDgsVHnqWBZXurR0vsKOqgs=; b=Mkxx4gmGeU1krnL0T6M/nKy5yf
 cyZeJXXX+ykXDJa0NCqMFcnfFstX9GDScTchAObLR5w5s9xzYWD4ACaUE8SlM4+yySRzLppJfoNXp
 z4l8DWBbpnYPVkgUU8iQpHkWyyG8wN6dKIfj21yWvPINd1Yy6iqlnNzPHnO/jHuJq+rM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AtgC9lgCiOGZOonyFaIqeDgsVHnqWBZXurR0vsKOqgs=; b=f+JpGA/xtkqaUTSnuiDo1hDh+H
 ZdEMiXfBj2E5C1TypYOM8dH72UAhsCd8HCYo1vAkJSi2Roh0gIVs+KRPoWPqn7pnZdY9o96YWC139
 7eGMHB/D+mVP2KtMJI/x/KX4BC+Ibm0PUkA3402M9gH1chkclbxuSMKuvBKEfzpJ+QxA=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTF9g-000000007P4-2Kp8 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 09:07:10 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so30138245e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 01:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794906422; x=1795511222; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AtgC9lgCiOGZOonyFaIqeDgsVHnqWBZXurR0vsKOqgs=;
 b=T4hWnletr3+7h5SJ4C7zLnKAfNPeMwxVqLwwme2T8plfDRasfKxYHJET8VjYir+Qc6
 fYbz5lAi732H+OUnj/F6juSBnzGvu2ajpN5izySAxE2tAJCERUw16bEDBeom3/hk6mFU
 vwr7yS8Y94CDao3YxVBnAfiJVmHeKvyIKTPa/f85kecqFBB+lADiZSAGBMzCnuime2m1
 +GgZwWDJ5T3kG7KJcPmfYcfCDhdSmsqr7mAOIFCmywVAMhN7iZvhL9tsVDwP1oqvuFtM
 SHgC4L70dugVE/EmIl3TVth5yODLqGcHdiCC5c08o1x5sc4y5vsTZar33yN1ZicTkVYW
 eJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794906422; x=1795511222;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AtgC9lgCiOGZOonyFaIqeDgsVHnqWBZXurR0vsKOqgs=;
 b=BHC3JKOxfWgNhUNOz0HlDYa+NmVU8P3d/zji7gidAWXUlm4ZVbskaAxzl2irZrzfCa
 afWBNSQ3VExq+W3w6BAT11RYVQcLSzm6vBcBJek5PzA0xNfc2i9UFTXGsPMnt5MOhJt9
 aVO2PsLoQRjcixTZvajfLuZ5+jAAIj18pO4LG28noCsxQOW5SuFNb9ZR07CQHGmp8qf+
 2xsQanogUWHiymSTF5xByJhGdlwF2aj8nOM2ckqmqZryKM79Bg6/0fpG4u7cF0xhW2EX
 iORFdRjZQNinWbLlsmi3RXfB8Y7aPuW1UntoVKy/j0OndKj+IvnhPT8zVaBcGVrjRFcz
 GT/g==
X-Forwarded-Encrypted: i=1;
 AL+hErEqLS9XAMqKkqGw3vQwjGN7bbLrGXCepsNsjJzpwLZKA/0HLC3oHWYkJLWzUayHjUWHXbGZR2UIkl3qhR0B@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8Zf7cqPLmkNpPOeeZQpPMd1ePjFmpH74CQnCFk8VL56/r5erEg
 wLE8RZOebVQLiN0JqZ2Al5aRpxk4/3S3aPqc8rrVDyvVWUam1xYhOP17z6Qm1ZZBj66QsUG9FMg
 3Lm4cF/zGMP76m4Aw3UToRB+k2afM969CHqlL1pUJJrfM3kVF6twigd+Kpstv0sEZzKod
X-Gm-Gg: AYBFou06dpQel9rdxk9OgVj9EBr13APm5zcanYJ9h7+8CQwJ4lKkd0x67oSBq7q81CL
 HMCxr7QN08vIbq9PwrB5Y4zIRRCgtx4YdYAUPGdwJc8FoE8W/VVwZbaR+r5A8HA0iy6RYqtysi1
 NTKwX2dM1QQqiTqY+8cjBC/YdzvQU8VmWycHoqVemCtInOb69E+j50ER69Vlc4W/eDyEX6nmL9H
 0QIjxxZcUx/1n8v3A0idNFiPGtYZSKEZZ18/U+UDUXAD7rjjpifXSzoHKZj11csTAgpyS6Q+qM0
 KgtG4w0FN8ujLfBCkVw9dPn8y0xGYBt9R3A6+PmW6wd9qDtycmsHz7nG/3THJmXhSn2ux4Wdwzl
 k5lOMcbYIMMdArNfcotrcIymiOSx5VTRdIGErClI4TADBsBM7hvNbICpQY2yyn6Pctd1wPaNIQx
 Dv8lfRwIzzBLSl+/Zm/dwwsbsXXqzNpsaaWPYxrKqz3nMMWicL0vUeqQvZrNdBT4FzzhHeQkIP+
 zY/rDKhyVPl7dZVfy61dWin5yLcQFnHImZBBBM7cZQRbkCijsvR7IWiLSrqxcy8FBydWmgx8Dps
 5JRCJPvvthTCarMswWKdw/jpNM0Y29rSmsy+PMTEcqnR/hCF9Lkl9hzJ5isjB4WjmNzYPqeHvcD
 phjRTQyrMx/rpgP6kWQt/RyWzNpDdkbdNf3VA0rQGkIh2RSpIktK0Zv1vO2AYA4A5PAGsXUlr34
 sYaFmDydTbimu2PD8=
X-Received: by 2002:a05:600c:3509:b0:4a1:dbdf:17a8 with SMTP id
 5b1f17b1804b1-4bb559f2cc3mr267643695e9.2.1794906421816; 
 Tue, 17 Nov 2026 01:07:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783853b5sm54065795e9.2.2026.11.17.01.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 01:07:01 -0800 (PST)
X-Google-Original-From: "Tommaso Bailetti (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 09:07:00 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2088345f10a630241fbddde68336ea7c1f7b449d
X-Gerrit-Change-Number: 2204
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2204?usp=email>
X-Gerrit-Commit: fe644a439bcc2f81b94365444a6b5ccca68879b3
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 09:07:00 +0000
In-Reply-To: <gerrit.1794861212000.I2088345f10a630241fbddde68336ea7c1f7b449d@gerrit.openvpn.net>
References: <gerrit.1794861212000.I2088345f10a630241fbddde68336ea7c1f7b449d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODYxMjEyMDAwLkkyMDg4MzQ1ZjEwYTYzMDI0MWZiZGRkZTY4MzM2ZWE3YzFmN2I0NDlkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <732df82ac242e747b88cae1181acee97df120572-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xTF9g-000000007P4-2Kp8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: don't access
 tls_multi in dco_get_peer_stats() during a restart
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Tommaso Bailetti \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: bailetti.tommaso@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Tommaso Bailetti \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1609225061998261448=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1609225061998261448==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f374me6pljs="; charset=UTF-8

--f374me6pljs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

T=
ommaso Bailetti has posted comments on this change by Antonio Quartulli=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2204?usp=3Demail )

Change sub=
ject: dco: don't access tls_multi in dco_get_peer_stats() during a restart
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:=


(1 comment)

Patchset:

PS1: 
Tested the linux section, when --persist-tu=
n is active the openvpn instance dies as reported, patch solved the issue e=
ven with very close attempts to restart the daemon



-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2204?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I2088345f10a630241fbddde68336ea7c1f7b449d=

Gerrit-Change-Number: 2204
Gerrit-PatchSet: 1
Gerrit-Owner: Antonio Quartu=
lli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: Tommaso Bailetti <bailetti=2Etommaso@gmail=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 17 Nov 202=
6 09:07:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--f374me6pljs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Tommaso Ba=
iletti has posted comments on this change by Antonio Quartulli=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2204?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2204?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Tested the =
linux section, when --persist-tun is active the openvpn instance dies as re=
ported, patch solved the issue even with very close attempts to restart the=
 daemon</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2204?usp=3Demail">change 2204</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2204?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2088345f10a630241fb=
ddde68336ea7c1f7b449d </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2204 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: Tommaso Bailetti &lt;bailetti=2Etommaso@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17=
 Nov 2026 09:07:00 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=

</body></html>
--f374me6pljs=--


--===============1609225061998261448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1609225061998261448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1609225061998261448==--

