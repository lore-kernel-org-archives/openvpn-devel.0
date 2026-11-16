Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCFB606A8A2
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=A2m4XiVM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=InOlEgGE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cgDVIE4H;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UDgtFQ1w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xsu5dojU0YYH1SA0zS4ePJtp9Yd2r8NudKIh3eQQAGY=; b=A2m4XiVMBiqwAB3iWZUw9zjUb1
	JJolSu0IqMi6suku1fkoQJd0pBQzs2mg6/87EqrfaNUq4zBlhK0CAqeKS5EbN5IzUMcm3nWGlHTBy
	xNy6Qdfwdpk2wKlNLv2OywNXR0vg5jvV98VMFoeyNOETOn0SvvRTmu7NQns73SMiVvvg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSwWN-000000003J9-1OSk;
	Mon, 16 Nov 2026 13:13:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSwWL-000000003J2-2i4j
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:13:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B88TOdO7bzI2MHx73QTXv7XJvj7kf628EeD37UgCs7A=; b=InOlEgGEwrP/n3stra5UB0hsZa
 y51pYPo4G78qGyhWHd6Z41psUoiewEh/VJPN6ID1GkL/JOMlWBUm+EPUUAARF9oyfZ1qscqIWDBuL
 eM8F3Lnvkwn15xDzrCEOsuyCgokRUHs76N9PKX4x2Kcv8+qDJaAb0Dy+BDVcAJZ7Hm+Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B88TOdO7bzI2MHx73QTXv7XJvj7kf628EeD37UgCs7A=; b=cgDVIE4HLsl3zok4CBPrw+5p9a
 wUxpGo2hdbsNR0XEIhZ+sPOMEjPWxVv4rdyad27NcVsGb+Nq1CXS4ljJcBlkY+C80R4lsbxwjKf3b
 dFm7f75vS9ZiwU/KTHlFUCGqUQWtImQeRjyfbVpg99x1CxmRnV022M6Tp+YnFW2hOGlk=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSwWK-000000004ay-08BD for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:13:17 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4a2f4ca0dcfso72624f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 05:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794834789; x=1795439589; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B88TOdO7bzI2MHx73QTXv7XJvj7kf628EeD37UgCs7A=;
 b=UDgtFQ1wUkCF6GKYKzIPgVP4athXQXaaB7//ebLaNf9vTqiVysjFJPQvu4EoiGUa7u
 vdfsZpoa8AjWLmGkETr+VtDOlJ14fBEjDGE68MwN9D2tLgeMx7vgQ5cKfxT1t5HTpQsi
 pAaLsSKjit6fe7B8zyQwbB8kKPt+wCfIn4y7ygHcLqhMJk2qn0CCVgZedU7rtL98aLFW
 rk0jB6fk8TwOP05g0/vkpk7qnGEZf5H8YHZGH8UGKutRsOcVD5IS9yj+gLJnHBH5/CRD
 RXZiDlwRVBkQVzvLLsHh+2TlkIPWRuV0bs5kRe2JuM90NloxJtwSVxPJEbdXqnRtfhnI
 +W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794834789; x=1795439589;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B88TOdO7bzI2MHx73QTXv7XJvj7kf628EeD37UgCs7A=;
 b=M+dAH1EftM4SWHZkeGOyirIlkjotzFBeUORGLw/85Hb+8v2/0OwQ5SiFV0pKiONE2r
 /2bOsmJErnD+a6a8v1kMNa4cn864sYRHJ0w9gRe65N6LshOMWWsPFmjfeUZpVpYpLdue
 EBHxJonVV8BQpBbvp5tjdv+uuNDEseJ9shp+lVpqu5AsG9gFkQnSXr7ZRXV1jbvbj8F6
 EHeqP/LLvkrnIMXMi3ZsfhCRkjaIXEedbKJNZr96SNTWnrbRSJXypGaJDVdDrfMwSrPJ
 hzMeJ9llNh5O96T9ISXM52hNezF/Nyxso6/UlGczz7vOqhSvPjOrkzaq34Kkt4ZUHD2L
 +glg==
X-Forwarded-Encrypted: i=1;
 AL+hErELkdxeCqpJ3RcrigdFEmlevww+9Elb9Xb9iYyECdLcLLr/cLlJThoPfPLS90JZXIV8NTn10QNylcrUCmvr@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8XWIOvtJAl8ESdWdjxYG3uwBvaNZG1I0rKk8Jg8J/h65pAPTyi
 S+N2FWLoakZmaP7dYMgDMwrNzYFTsxAhAsk1lMICy09xY00Wcprq6pN6iDbvRO/1giY2q7vmHSC
 ZRXm/AsM1w4kEwshc53ud6tHcp2CIJUsv5ZSmYsNfEhyj7RfIU5iH8SM9EnpTtjrFYEVy53WfGG
 KybQQAmw==
X-Gm-Gg: AYBFou1JvRLRJ9O8gmSicISmDDBbqJ7TQ3J9AQbLrWG+P2EHVEo0Av3cqQKWzN1hxXS
 v3k6akXrQUqM+Vp+2T0fh48kkuqXBFo9jAQTM1hJGUNcQvIYDC0i5ah7NJlAvVnChGOiwwZvfbg
 v3dHxMZli3L5G3cX3pAi3KD7gTNcBlElmGvcZe4KUnvuzjopk3+comJ9cXVCKbc0GcLM6ofq69g
 0zzSh5wvoUCisN0kkPpkkYt/l49OBjXMETpRB4km3y4RIB+DfK5BYcGo+La55kJPScDtokiY5JD
 N1hnJDLj0U81YSCmELOnbCA3/ayKLUKGpZ31ZQiIAJrb9uDQu1cUXJO7GT6etdHStCYE6clMIZR
 zPZE1oDa1xh1DcLXlZrJTiJHwcuDLCv+j+88Os9yj1SHu088nxqEq/F/UW3uybfbQwm57b+slYL
 Xrth/RybgoaNnf874t4QSMOPjU4p05H5dSInjewvPP00Brmntl7GlXlCfJGkCQ/oaLn96GLDC3p
 dPBV47f1QdcABe0AWQqcNp3u9yzl8q9CKxnk/8ScBr8o3TudbwxLLRkYIRFyJedwOnrt1Jr5ATP
 HZJmSVsfWGd28wy//GlhOdhJeXHDeBES2PwVvFwc9Peg8kc0yHVGT4xnt03NJClaYcXIgncOdjD
 AhU5TmQcC3/LHz/25VTIqWl8SdK94xfYSAeIC2H1doUxQb57Sxrp0dwZgOvR1LpoXgIaoBJsvVk
 zyAlYM5QP4PW+4mI0=
X-Received: by 2002:a05:600c:c167:b0:4bb:6a75:d04f with SMTP id
 5b1f17b1804b1-4bb6a75defamr78917845e9.8.1794834789252; 
 Mon, 16 Nov 2026 05:13:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571d7e87sm198994815e9.3.2026.11.16.05.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:13:08 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 13:13:07 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibea20c0f2c3df9f1f6509d662ab2b5fb4ce5e18d
X-Gerrit-Change-Number: 1531
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1531?usp=email>
X-Gerrit-Commit: 1056b69289db0a8464ea8b7a14009cee1d01611d
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 13:13:07 +0000
In-Reply-To: <gerrit.1771250081000.Ibea20c0f2c3df9f1f6509d662ab2b5fb4ce5e18d@gerrit.openvpn.net>
References: <gerrit.1771250081000.Ibea20c0f2c3df9f1f6509d662ab2b5fb4ce5e18d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcxMjUwMDgxMDAwLkliZWEyMGMwZjJjM2RmOWYxZjY1MDlkNjYyYWIyYjVmYjRjZTVlMThkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <530b9f5d7c8f7ac1007c586ab7f97c2b06f5a857-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xSwWK-000000004ay-08BD
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: management:
 resync timer on bytecount interval change
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2385364908658954924=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2385364908658954924==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ouL3maCLpdM="; charset=UTF-8

--ouL3maCLpdM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Ralf Lici has posted=
 comments on this change by Ralf Lici=2E ( https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1531?usp=3Demail )

Change subject: management: resync timer on =
bytecount interval change
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/manage=2Ec:

htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1531/comment/c5ca2000_1a51c973?usp=
=3Demail :
PS1, Line 494:     if (man->persist=2Ecallback=2Earg)
> All the =
other uses of man->persist=2Ecallback=2Earg seem to just use that without c=
heck=2E [=E2=80=A6]
Sorry, I completely missed this comment=2E

The check i=
s necessary because this function can run before `init_management_callback_=
multi`/`init_management_callback_p2p` has populated the `persist=2Ecallback=
=2Earg` field, specifically when `--management-hold` is set=2E In that case=
, the management interface will still process commands while waiting for th=
e release and removing the guard will lead to null deref=2E

Other man func=
tions do not need that protection because they check the callback presence =
itself (for example `man_status`), operate on management state (for example=
 `hold` or `env-filter`) or have other invariants making the `arg` check un=
necessary=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1531?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: c=
omment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-I=
d: Ibea20c0f2c3df9f1f6509d662ab2b5fb4ce5e18d
Gerrit-Change-Number: 1531
Ger=
rit-PatchSet: 1
Gerrit-Owner: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 16 Nov 2026 13:13:07 +000=
0
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>

--ouL3maCLpdM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Ralf Lici has posted comments=
 on this change by Ralf Lici=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1531?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/manage=2Ec:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1531/comm=
ent/c5ca2000_1a51c973?usp=3Demail">Patch Set #1, Line 494:</a> <code style=
=3D"font-family:monospace,monospace">    if (man-&gt;persist=2Ecallback=2Ea=
rg)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">All the other uses of man-&gt;persist=2Ecallback=
=2Earg seem to just use that without check=2E [=E2=80=A6]</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Sorry, I completely missed this comment=2E</p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">The check is necessary becau=
se this function can run before `init_management_callback_multi`/`init_mana=
gement_callback_p2p` has populated the `persist=2Ecallback=2Earg` field, sp=
ecifically when `--management-hold` is set=2E In that case, the management =
interface will still process commands while waiting for the release and rem=
oving the guard will lead to null deref=2E</p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Other man functions do not n=
eed that protection because they check the callback presence itself (for ex=
ample `man_status`), operate on management state (for example `hold` or `en=
v-filter`) or have other invariants making the `arg` check unnecessary=2E</=
p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1531?usp=3Demail">change 1531</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1531?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E6 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibea20c0f2c3df9f1f6509=
d662ab2b5fb4ce5e18d </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1531 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon,=
 16 Nov 2026 13:13:07 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </di=
v>
<div style=3D"display:none"> Comment-In-Reply-To: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ouL3maCLpdM=--


--===============2385364908658954924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2385364908658954924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2385364908658954924==--

