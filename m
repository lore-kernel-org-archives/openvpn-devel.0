Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F360606A32A
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LFcArS6H;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Q1P6DVrD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BsJxeoSR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CvYb4DWA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=m4LGMJxIcPqux0Mp55duP3gs6Fb/xU6/kea2ooYiBoY=; b=LFcArS6HXrn+EK0Ci/p6VaUhhY
	q0L2wFmUBch+UrQs+aFYYQICwTIjT0J8QC9M+sVPXX7WUJMYNfLCZ8rVzMjhSslaX8my52p1uMg7R
	TJfu/oOSH+x9Inspr2IG11XdF7u1WsYN78FcqKqPj/mh/cFkTM6ocT/BhpYTqJXjgEfA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWcBU-000000000Gl-0NSH;
	Thu, 26 Nov 2026 16:18:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWcBR-000000000Gb-44Cw
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 16:18:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5JlhJTthZj9AISCj1uFFlrkG7Cgg6p2L2eG7fsFr98I=; b=Q1P6DVrDK/uzDqUwlnyfOP7jGP
 YKAX8FtMDYtkY8Ov/DI+H0THekntpZlNWecQbvjUpa0Hf/vHZzhCMbVg0M6Qzx+nq/c5N5jUvl77v
 Ta2487MElLRwVaNS6n1xpvD2xXSkIzIfMRv/Mh8xdh1nlQIZycD/M9eHuwtxsVR290Hg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5JlhJTthZj9AISCj1uFFlrkG7Cgg6p2L2eG7fsFr98I=; b=BsJxeoSRtscTMNOciq7s2/b+9+
 T7kt65ozLcxWTaunTnBwVcjDp+l8MqT8Ch6Ph+yYyIRK0XTnCqwkgqAPn4K2us8/CFATLRoZ4nGT6
 XvzLR++D89IQoHVWccJ43OtsRKCNXPaLikh1o61GIVO8hR2Io03+9GzrgaV3P/+4WOu0=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWcBP-0000000087u-0ezX for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 16:18:53 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso72470825e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 08:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795709924; x=1796314724; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5JlhJTthZj9AISCj1uFFlrkG7Cgg6p2L2eG7fsFr98I=;
 b=CvYb4DWAA2Z4eoTZF8K+gjgks7f+ZBlUM+MEBTccqXK6qgie8RBfJh85oyiabFi0EU
 XjFQzxi+CuCbBAmxHEVaUDtyq5M6EIahA1O7fine5G9WnfY8Rrm+YWvwRASYDqv4ZCpt
 0blycjDuxjj1+XawNFeIekX8UOWxcBSfGOFPOq0r3W/FJY1i4cN/wICkpozClAvRCWqX
 BGwga/RFM2nqM2ShFHiXYb/VW7uL3i3Y8uLLeMPBgBDp61wHenHQ+7smlzVFj+WftB+B
 l0KYpqxZogB9nQt0nhC/HLlRD7dALRktbYu9eqOTxHJMTpSOFrAjxbq3AeT5NxsKhZ4A
 OpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795709924; x=1796314724;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5JlhJTthZj9AISCj1uFFlrkG7Cgg6p2L2eG7fsFr98I=;
 b=nMmsVh0DtGLulzns5yPHOq3Gd3qopdKPwCY2agv+cr6PgyFiATWY8MMBbalRmTKUZN
 EeUm10346GrqlK3YZ4QivbmpkX42chHklMtTq79kGRJFdpuN/ATnFqHtaO83n4Ch5wzS
 HgXUVctZFknOjTrPu2agVIy6doWYCcSNSXiMF1XIDjSJNctmZrT/GR6flOYzXdQIXqp9
 ZPnCG3Eb7XcW4FFr9jsbH1FEbILmtlbsVAF3PzxWbLo9jrZZFht6oVRXaCJFVDybqvGY
 ttvcq8QWQ3BwdL+SU0Wr7CqFbAUOC22kGidoi9tz/o0LFoxed55PoFl0P8ycXbNs8kzd
 dOLg==
X-Forwarded-Encrypted: i=1;
 AL+hErHve5+E4kRxWGzXTLdO1bPQiS+CWGBtFZHzv9k9KKAJworHTJegosIth5LsxIz3quGUKB0RkZjzLpLnpeLu@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8h2wf5OI8/f5AXyzXntyk96W4Y1l6jOWsw2R7bWKF7vmHTVA0V
 S7Av1Ibmq42dzstLsJc2VzSEZbCoGL6Tgt3uTAISPl4V61BNdrdRYyHHeKbMCUfThy1xVZIhR0p
 O/USI9WRJ02RSg+InRUH89lo6mmGvXdwP9hi1PPi3206JaGVCCO8SILqBh8liDCi3LIoUvI1miY
 QTbsi/hA==
X-Gm-Gg: AZFdTZd6OZgqTmEnGRsbpKhMwzCDB/8P0aY8ZwTDfr3PMeLgY1D1VGcTM4/wmt1HKZw
 crkvXvlxf9Apue2Ro6BDbw9LCrt10REgJDReN6rYL7mWfZnU6SALpEt2jmNW9dwUwDMqKFbg/OE
 09hlDdTdFVGfnUdYH+g1CLqivfQiJMVDaF5XRhD+oDNekFuaWCgLxNb04JFlTpSYYjwUB1gOQBG
 PcXHc/B64SGBUBF/tWSp+URRDKVvtwn9It8Vgx37RjceM70eZoLjDw/EFKnem8o27y+DVoX3zd0
 PteLFn61cLjzeSu0CtHxkyRXa02QLdnUgxRuTB/QQ1gWM7fG7GIZ+7E29wY1nFcdwRXGR5oeG1i
 x2hrMBpUWubkjZ049tUuDdAbq5Ny7a/E8eULXikOtyeePzFFOcKpvmH+GAMmUx/LcqKUnodaFGX
 B0MB+0jDKrSVq8PKQhmtF1SNm+V24VUqvLe1ZCJf1ORg+hpQlbgGZghsUT0dJNYYeQUyIJTF6cR
 tVMA7xb7y/ZhyDGs6ac/qwy9rwSpoLCyXQ4WAUO5ETqq5+zxhRlq2QWuNmxVwEvasNFXD4QYMa7
 6TeY0CfBJTYcBmJJFuKRRpHq+DZDs6+es8BIBLtYv9UTN6/NXnOaMRawFccJO7DunaLqG0uH7Ww
 ju1YTkdAAJkXX+fIITlkyH4NZz7EsAaAeKDRbBtxyZ5npBwiUB9+oRP35YjHhm3e9+IYearGeVE
 ZMWAAgMIqBnqAvH3A=
X-Received: by 2002:a05:600c:a55:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4bb88827db0mr461419045e9.30.1795709923269; 
 Thu, 26 Nov 2026 08:18:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884ab091sm864867385e9.11.2026.11.26.08.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 08:18:42 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 16:18:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf
X-Gerrit-Change-Number: 2355
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2355?usp=email>
X-Gerrit-Commit: 9673b2028574e8d6b5e9461400e6b8da1cc83d60
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 16:18:42 +0000
In-Reply-To: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
References: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njk5MjA2MDAwLkkxZjc3NTk0MGMxM2NmOTg5Y2Y4MDRiZjYzN2Q0YTYzYzNmZTVhYWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4e6713b25bc445cefca7ab2f891d2c473454187b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWcBP-0000000087u-0ezX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Cleaning up Windows
 error handling for sign conversion
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8784553145603208367=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8784553145603208367==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ePfpemHkLo0="; charset=UTF-8

--ePfpemHkLo0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail )

Change=
 subject: Cleaning up Windows error handling for sign conversion
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(4 comm=
ents)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355/com=
ment/721547bc_d82c5dec?usp=3Demail :
PS1, Line 7: Cleaning up Windows error=
 handling for signing conversion
> "sign conversion"?
Done


File include/o=
penvpn-msg=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355/comment/91=
ad2485_a071baca?usp=3Demail :
PS1, Line 160:     NETIO_STATUS error_number;=

> `error_number` seems to be assigned a variety of types in the code (regi=
stry `LSTATUS` values and `E [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2355/comment/c660f118_c9e6cdaa?usp=3Demail :
PS1, Line 160:=
     NETIO_STATUS error_number;
> FWIW, this header now doesn't compile on =
its own anymore, because it does not include netioapi=2Eh=2E [=E2=80=A6]
Do=
ne


File src/openvpnserv/interactive=2Ec:

https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2355/comment/058707f4_0a187df8?usp=3Demail :
PS1, Line 3077:   =
      err =3D (DWORD)reg_err;
> Why not just `err =3D (DWORD)SetDnsSearchDo=
mains(=2E=2E=2E [=E2=80=A6]
Done



-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2355?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf
Gerrit-Change-Num=
ber: 2355
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Comment-Date: Thu, 26 Nov 2026 16:18:42 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>

--ePfpemHkLo0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail">Vi=
ew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2355/comment/721547bc_d82c5dec?usp=3Demail">Patch Set #1, Li=
ne 7:</a> <code style=3D"font-family:monospace,monospace">Cleaning up Windo=
ws error handling for signing conversion</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;sign c=
onversion&quot;?</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File include/openvpn-msg=2Eh:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2355/comment/91ad2485_a071baca?usp=3Demail">Patch Set #1, Line 160:<=
/a> <code style=3D"font-family:monospace,monospace">    NETIO_STATUS error_=
number;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">`error_number` seems to be assigned a variety=
 of types in the code (registry `LSTATUS` values and `E [=E2=80=A6]</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2355/comment/c660f118_c9e6cdaa?usp=3Demail">Patch Set #1, Line 160:</=
a> <code style=3D"font-family:monospace,monospace">    NETIO_STATUS error_n=
umber;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">FWIW, this header now doesn&#39;t compile on i=
ts own anymore, because it does not include netioapi=2Eh=2E [=E2=80=A6]</bl=
ockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File src/openvpnserv/interactive=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355/=
comment/058707f4_0a187df8?usp=3Demail">Patch Set #1, Line 3077:</a> <code s=
tyle=3D"font-family:monospace,monospace">        err =3D (DWORD)reg_err;</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">Why not just `err =3D (DWORD)SetDnsSearchDomains(=2E=2E=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail"=
>change 2355</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/23=
55?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 2355 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 26 Nov 2026 16:18:42=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"disp=
lay:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt; </div>

</body></html>
--ePfpemHkLo0=--


--===============8784553145603208367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8784553145603208367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8784553145603208367==--

