Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB53606A895
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j0Fmp8w0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EoJKzxUP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DLnTEE5y;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LjFjIQkU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wzQzyLqkF3SN/Sm4r8utqXir4qHYwCAj1oqgmLZ0FfE=; b=j0Fmp8w0yxLJvr9D35RJ5RmL53
	y/jxFAD7rOmyIgp7vZv9x7LuD7VaJmTlJjrCZYTdo/7vKOxQAxt2ExF9Gp0XmAAmqbq1tWjsriKTU
	UuTnxdeC8jfdO/lbLE0hhoWLzC72D+UbI9LvwUH0Es8oHn7QVLbiUWTqcNjTCbDrqdgU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSvQb-000000001il-2TMp;
	Mon, 16 Nov 2026 12:03:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSvQH-000000001iG-3rIW
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:02:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZV6Ypf6ZHtKbV3QRkxiiFcQ9IoN0VlWukErFwJJ5j5o=; b=EoJKzxUPyPPaRtyIbSN92u4XHO
 jfAIcj2EnBQny5vY/f1+ZW6r7nvXZb06rVQnbKm9JrqeXZmnKv/W5ijpuzU+d0TXE7hBF0/xYpBcJ
 o2wSHH0uTlmU/XMyUnhimrvM+zNni1gD+fP/VeaRXEjDPZrqWYkKaGoAGjWeCdWymgdg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZV6Ypf6ZHtKbV3QRkxiiFcQ9IoN0VlWukErFwJJ5j5o=; b=DLnTEE5yhGmYcq3/XIO6RrshDH
 ymQK81HnCPl5PpvYoiNQWcA5hHKpEMa13YtfRe/oRGs1tdJB6bOYT3vqn4qCC0d+/vCBkWYVuIL1L
 PM5/+4ycr+gZVo4lXezvLvaU5A9KsxoYaljQ3jZv1hf6m7uKB9hO+iaaoMyracDtP2Uw=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSvQA-000000005JE-35eN for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:02:51 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4922dbcee23so1561370f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 04:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794830564; x=1795435364; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZV6Ypf6ZHtKbV3QRkxiiFcQ9IoN0VlWukErFwJJ5j5o=;
 b=LjFjIQkUQiMpjqafeTw7qE1i6ut7ZkmssjrQuRpFDmFPwWqVAmwOOCClaS2pnmZnOs
 MWbAnu9ReMpBgte0HSkMjdGZnPwfHf0VJN/5ay0J+CDHEzSyXqeOtuGD5EQbv2GbplN6
 ov/ViXL1SfN8TNxObf+EmeXb7MlOsHDLDAhX714Vb/T5N3X9NLWLWD+LQcJUz96Yu14g
 1DBCvq4xgkxpI+P8lwmoSTSVDAT7VqaoYI5gG02yP4IFCdZMosWNxHV98fSGQhjnmCc/
 HToig55HGLKpVyYYyyI2/FemnBzzxWq39yEowC4ExqQGg/dSmTvRcM4glsms1Ais60Dv
 PF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794830564; x=1795435364;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZV6Ypf6ZHtKbV3QRkxiiFcQ9IoN0VlWukErFwJJ5j5o=;
 b=dNncHg0/Q2PC7wC2zWG/sIesxu38ZKda1SPW16qbzSsWB2G/mMzwy33vpYxHOPOQa7
 fFXGdvl3E7KG3Gyl0wFSVrbCRdmdOXFLPFlFZ8QGpmwlxTVuKHs/MT1rfDIiA8hgrtU2
 VHXNU9kxWFhSYNdmX52D0FMTP491bzGgC10ccF8wABJNe5AKT3bI4J5LAAG0qUTslvkm
 sqPcRxTU8bxuQFrDblGYPSu91zHoJrp4vPueH8dlcwyMyecIyjZdte1bROmYJ9gjWVeh
 o5gmqsefntFyitHk+7yxzLzD+g4TIzDh6vQ/f7NdolixsuANCkgbzIF5s7mkruTiNtJb
 UHbg==
X-Forwarded-Encrypted: i=1;
 AL+hErFkrva6NZEQKW4BqsG2OdG8g6wTJCpeyi10ir0LuTstaGkJd+OhYf3jIyDvOnsiE6T4mdjLwzO3fxfYVwMz@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/Q+lc2ONLL0rlTllPEKJZ9iL3DySdZD5v3NWQrATWCoEVN5C3d
 lsCfw6IZQzgVm/CbT136FZl2W/MU9cdddVCpPwVZIKOmcNv9iawyBni8AJpQIPHNtYWUcTy272+
 ov0kbg0I7vxr/Ji6cDJQWgntIYMcXD3V6U8jDFth2ALPAEJv8HQj6/dh6JD2g93Q/ZXgW
X-Gm-Gg: AZFdTZczMwFijNYaLPA/gO6+nL8V8A51w+ZaKIxxpzxsV61c1K6B0N7FArK3Mk6fF/U
 dJlWnxsYIUCb4D5wqaMWJT8eKpzwGHvemTlLp9EX7wUlBb4wZBbrAZ/FNwkmj0avuuGs96B2qsD
 C4KGGGS4h1+gG+MHPLpBPU8fVBDWE46t5EgOADTSgk3WIkbb/UscACjAcnfPSYgB8CABYfs4laB
 PkfqSoOkArVi8BeYNcpgBY5JI+rsTi1RWn5PbrN4OFu49LSdsaMjiTQlGgBVldbNW6a6clEc9GL
 JT1Oaz0Ay9QAQlNSS4n/GlIWyqVpMqaviuUCUvYKvlc6oZrFtQvE8xTGXHqKwusR1K30QNDjCMm
 rUpo2ttACBM/WUxD8u7sGWRzyyX8n5PZza32uZ1y1K/0kNZT0Nyx3bX0WMv0FfzsQ2A7AVUj39L
 wq8eEK9IyIwse/QBh3yMmfGWto7xjHl1fYqk+RZtq8GqSZjJ1amKjZybRorTI0PiMt8yyYh53fV
 q7BMEcrED/HblQsf7ZFSeZk6G09+TCZ+CBuNCtwUU4NU/TgKBDb88TtcGth+lYH+u5syLEpVHZT
 eEmmIADVDzcZeU896tGbmpVWayIgtLi4X/oBXyeXjJeHLzmUw+N+RHjtWM9urLAziveUwXoC9xC
 5iVue7Wyks6ohOmn0SYYiEYhQuDjhtN8ZNpZVbwJl5y8gu35TUWmFIi710IB3xV/fYX9ToWaldY
 SeknxRsYhGC24iBEI=
X-Received: by 2002:a05:6000:2510:b0:49e:4ba2:a775 with SMTP id
 ffacd0b85a97d-49e4ba2a9b8mr14049242f8f.56.1794830564006; 
 Mon, 16 Nov 2026 04:02:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c1797sm24222467f8f.11.2026.11.16.04.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:02:43 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 12:02:42 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
X-Gerrit-Change-Number: 2177
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2177?usp=email>
X-Gerrit-Commit: 5f21576c5a3cd522f75975f2ace80184e713cabd
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 12:02:42 +0000
In-Reply-To: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkk2ZjVjYTUzZDQyODhiMDkyMTYxMGY3YTNmODRhZDU1ZDJhYjQ5MTE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d566bda8b20104fa152e66eacbf994b241befbb5-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSvQA-000000005JE-35eN
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking_sitnl:
 Reduce boilerplate code for parameter checks
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9071727148730691611=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9071727148730691611==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1j9qAF0NUyk="; charset=UTF-8

--1j9qAF0NUyk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Fran=
k Lichtenheld=2E

R=C4=83zvan Cojocaru has posted comments on this change b=
y Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?us=
p=3Demail )

Change subject: networking_sitnl: Reduce boilerplate code for =
parameter checks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 3: Code-Review+2


-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2177?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
Gerrit-Change-Numb=
er: 2177
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Eco=
m>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Atten=
tion: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon,=
 16 Nov 2026 12:02:42 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--1j9qAF0NUyk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Frank Lichtenheld=2E=
 </p>
<p>R=C4=83zvan Cojocaru has posted comments on this change by Frank L=
ichtenheld=2E</p><p>Patch set 3:<span style=3D"border-radius: 3px; display:=
 inline-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code=
-Review +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2177?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; padd=
ing: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2177?usp=3Demail">change 2177</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2177?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn =
</div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49=
118 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2177 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;ant=
onio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16 Nov 2026 12:0=
2:42 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--1j9qAF0NUyk=--


--===============9071727148730691611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9071727148730691611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9071727148730691611==--

