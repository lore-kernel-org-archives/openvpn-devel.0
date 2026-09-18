Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0B2C982D8
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 12:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IOxxzruAdmSnCqJxtl3pRIR20fV1hrxNzjtqdUDc+Qs=; b=QYn6cNYHGwgYzq/Je9oW5FCr7q
	4xSMhC6Cry2lSEHYtg3b5M97M9Y0F0D1o+hiXWpmQ/s0fudtqQGMjx3cUpf+HkYNFlHcZ+4/bv4xx
	W4OLySe/8+Yu8vDhkfzD3reF6hPQqDYI1OKEqnttFTs1hbsmj2Qxg4q/24BbCBHfkRo8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7Y5o-0004TV-Fn;
	Fri, 18 Sep 2026 12:53:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7Y5d-0004TK-7Q
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 12:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=p+3EoI2pfwYzuR9q/CZW5wh/BEz/Z//Jzina3U+GEB4=; b=Oea3KabvS6sPwkUv2/woPn1a3I
 Iq5pQq3bzbgC/ef9HrP8YKj+h8XbBtiGn6YRIRjCd+Pu4UkegghD3XBhGIn/jPBjkfJIi67WGhMyO
 +yHa4s3ACD+eptwYimS0GAzOlSNCpYScF5ZOgawU7ZiW5cL+aUYheaCpeDywiVlt25Dg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=p+3EoI2pfwYzuR9q/CZW5wh/BEz/Z//Jzina3U+GEB4=; b=T
 WH4AZbYGudm/FMXoirXbsmGUGt6CXBHjGHOvQOy1UjADVSJ+ZsL51Ham08yk3Up/UupFMXEnDUAcY
 UzrdZN9NTSDtLY6ic+VJYobrlUAVPCJaymxm2GIHXbThMfmxtS1sX0GHc3fYcojQ9lVsUrQ7CeqSI
 4wfP9BlTWzDf7zUE=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7Y5d-0001Rx-9W for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 12:53:17 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso4983435e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 05:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789735991; x=1790340791; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p+3EoI2pfwYzuR9q/CZW5wh/BEz/Z//Jzina3U+GEB4=;
 b=fV7VAf5KNDi02kvv0v+utb87Ao+VIFXyjssoH2vI77HraMB3Cbz+7d5k5mWv0KSTwL
 kdALTWE0Ox3DDBG1aiEacIQlhCzuuldzwy+TTDL3I+vu9W1rE76LFOj2i8Zh/kEWUqEC
 WRHox3FKH9B2Gfoind1aYX6qAVkjN3WY8MlGwzm5v+PuTXkkwCoPsQD2dXnJkoL4jYbr
 gUMIjNCnu2DFRqslY3C8ulnXahEufFfPFideJp9YlT08LftW8a3liK2PHPoxrHdjElnZ
 ncJ6W3pu7R2SiZ10+fHbFXpCjhZ5vldLxXBeSf15q2YS3mFIoaqt3xmHGspdzCTJoitS
 Y7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789735991; x=1790340791;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p+3EoI2pfwYzuR9q/CZW5wh/BEz/Z//Jzina3U+GEB4=;
 b=rnfg6EVhNU0zVYPTC7U/u6O2v0vkHto09We59egj1NF15/PmzbJ6F2sWqjsAo/aWB7
 sDmO+q95UnqCdcIOoTkcURlXKATIrT3Tzk2gN+xrKDC797awvRQCk7H92E88FodllQV6
 NStPXfM6A1IHsMm4akzP+CdDd2BC3ccAC0Osd458xcmUien7m2JgBW6uhYHKYxUZdQX6
 xmfKUKEXH9aeDlTry7BVAiLeEiqFDXWvG7+U+F6dYcBwvhdOS2w/MtFNvuL+fj71MTb8
 biYfJvDKmKJ4QV5IAreiusuaSILcT1Mhs+CoMA3Roa7JPI9Fc0dwEe19tOlDXNpZ4mw6
 GsCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrwrY/QyFUbnYW9hbbhAdlxp7lIM/XmmDocSekOoX8YUDvDfH3F6qTH3SZ8TC7JkWwcQECJWmF1FQLmobk@lists.sourceforge.net
X-Gm-Message-State: AFuF++mF/JSDT+LascS7VMzK7Da1hgwJJu/jElKp0voEAuZpAV6iLO1S
 m3oiG4szvdiBHG6scvV7fI4nsSZYOb3V/HT+1MKirdXmOdJnImPVWt08dcCrLUIOMCDY356HBBT
 6ie0R4QESkZyHyv5yJVZl69gwJM2qrs3Ptl/ZOGZ0aTpfSbRWQPLdTi7S5oKkBEVJIE5D
X-Gm-Gg: AYBFou30OfKIu/uPK46dSmw563l7zBEr4ibU6j39HE/FAniy7FQGF3vu/n1Gyrv1XBy
 euayT9JZTBQoE6qqUK+2mz/WQaYsEV7nQNdYCYw8NHf5kWzdaWkJ+mDERtwDiCchAaohQ7AaNQp
 hj87+G4IPXqiKu4DP+KYR/l3Bxg5AYYQGbpdtNApXcEttoaX1cyXEqILp4mT3VllEYSg0sX34Fy
 BIjArEvHye0yvzTcoUaNx0RPtPM5fHPi6sLqht76uVd/B/LG4/ATS4t5FbP285bZLzMUgQlqchw
 lGv05I6+UtfcXdXwQDDExpit+PjFjwXclNx5ROIGUq8xuqsb9aPOaloOBhn8B8gv1Wu2fTu6w/8
 2F026RnbuWg42gBtZbA6KUsmYaVvd0pfcER/AcJEggACXaPkuVw/Jvl/DoFABbkHPVwuaMEJgD4
 /MMdPjyrDJWC2oRhRwOCQomv3hsNYrGLBfzBXWYyJJSNl5Mek1RHmNx/VYGWMUQcuVj2lU/OYQ7
 3TEkp8B1shQ9JOZiwx7yWnMKeqQyBpnlQeONo7H0y89a+0Te+DrQrjtcGkthfjZFhjq+1Vyc97y
 0UxT+a2T6fGvBXndHGILks+SRen+2Mdo+RcI4D2pAz53MQAzBXQt22zkU6Kpsw==
X-Received: by 2002:a05:600c:19cb:b0:49c:fc6c:be13 with SMTP id
 5b1f17b1804b1-49fc5740216mr30952445e9.25.1789735990507; 
 Fri, 18 Sep 2026 05:53:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7ce03dcsm56005005e9.5.2026.09.18.05.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 05:53:10 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 12:53:08 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 46cad7fe12200e06128793f923efef3e05c98ab3
X-Gerrit-Comment-Date: Fri, 18 Sep 2026 12:53:08 +0000
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <91f7ba2ae45a130be07b53bd6b995dbbe707a142-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7Y5d-0001Rx-9W
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Answer
 SERVER_PROBE on the server (P_CONTROL_OOB_V1)
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2015146412602573484=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2015146412602573484==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Issg1tethQQ="; charset=UTF-8

--Issg1tethQQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


stipa has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1744?usp=3Demail )

Change subject: oob: Answer SER=
VER_PROBE on the server (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 17:

(2 comments)

File src/open=
vpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744/comment/41452=
63e_2e5614fb?usp=3Demail :
PS16, Line 138:         || verdict =3D=3D VERDIC=
T_VALID_OOB_V1)
> By including OOB packets here, `initial_rate_limiter` is =
charged before `oob_server_probe_check` cla [=E2=80=A6]
Right=2E The shared=
 check is back to reset packets only; the OOB path charges the same limiter=
 right before sending the reply, after the malformed and stale checks=2E Dr=
opped probes are no longer charged=2E


File src/openvpn/reflect_filter=2Eh=
:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744/comment/ea53f1b8_fc1c2ab3=
?usp=3Demail :
PS16, Line 49:     bool quiet;
> `quiet` is not initialized =
by `initial_rate_limit_init`, which uses `ALLOC_OBJ` rather than zero-ini [=
=E2=80=A6]
good catch, fixed



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Gerrit-Change-Number: =
1744
Gerrit-PatchSet: 17
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lic=
i <ralf@mandelbit=2Ecom>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-Comment-Date: Fri, 18 Sep 2026 12:53:08 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ralf_lici <ralf@mandel=
bit=2Ecom>

--Issg1tethQQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Change=
</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1744/comment/4145263e_2e5614fb?usp=3Demail">Patch Set #1=
6, Line 138:</a> <code style=3D"font-family:monospace,monospace">        ||=
 verdict =3D=3D VERDICT_VALID_OOB_V1)</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">By including OO=
B packets here, `initial_rate_limiter` is charged before `oob_server_probe_=
check` cla [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Right=2E The shared check is back t=
o reset packets only; the OOB path charges the same limiter right before se=
nding the reply, after the malformed and stale checks=2E Dropped probes are=
 no longer charged=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File src/openvpn/reflect_filter=2Eh:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744=
/comment/ea53f1b8_fc1c2ab3?usp=3Demail">Patch Set #16, Line 49:</a> <code s=
tyle=3D"font-family:monospace,monospace">    bool quiet;</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">`quiet` is not initialized by `initial_rate_limit_init`, which uses `AL=
LOC_OBJ` rather than zero-ini [=E2=80=A6]</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">good catch, fixe=
d</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1744?usp=3Demail">change 1744</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd=
1d108343d59f0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 174=
4 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 17 </div>
<div style=
=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_=
lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 18 Sep 2026=
 12:53:08 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div styl=
e=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@mandelbit=2Ecom=
&gt; </div>

</body></html>
--Issg1tethQQ=--


--===============2015146412602573484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2015146412602573484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2015146412602573484==--

