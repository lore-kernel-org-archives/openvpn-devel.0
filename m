Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F1A606A326
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=m0+ss9Ig;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SdPwwU43;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AvpWNqhz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UG/IB+B5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PyI08+29OoQ65yw0WZbi89mhRooME0eRcQ4iqmoc3+8=; b=m0+ss9IghjM7l+Ng7G1Y1LxZFp
	epvlpOSc1Wj07CiGViPHGSuYENg5ZJTin0Kg7Y1nffUAzxdC2JsoWWBjmQ/5Gwn8iKxYN1Pv398Z5
	darL5BZaUhHDoBQkPn+E/nHaaOpeNBadVUL/dGKXtM1OUZSbwv/SFnq9WUdy1B5y5WkQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOvWn-000000005pA-0q1Y;
	Thu, 05 Nov 2026 11:21:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOvWl-000000005p2-3ESs
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 11:21:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zXlJXj9kW6CcazbmllVYa+E4AFFo3cz96WBOI3puXq0=; b=SdPwwU43xLSvwod1pQ8GGTK3oL
 LlJvuxbJ+T5kekBbU32RtbvSJVpmi1SjY4+lnPNmWVzL3aUkDEqQDxkmElInaKMei4UrAFB6b9J4U
 qGf40fjhKT2e9bJ2mxT8ySdFc9gI8whCngvw3ZLKqwDomcqxjHj6zwdk5IJcmEw94PIk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zXlJXj9kW6CcazbmllVYa+E4AFFo3cz96WBOI3puXq0=; b=AvpWNqhzjwx/76XMDh0qFRVw9Y
 t7/oZmXmpHTJ3irH6ls/8gs1fsvial0rSRrOXtGB6CZOU44MTL5YxOiK+YPYAPl7NzYTl+iKefzq4
 vLX3do5IVells85u35WI38KHLfO+lWrVdIJvT79koyWvBltw34WYy0Y/uBMuafdSa09s=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOvWk-000000001LL-0mWS for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 11:21:07 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so19024175e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 03:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793877659; x=1794482459; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zXlJXj9kW6CcazbmllVYa+E4AFFo3cz96WBOI3puXq0=;
 b=UG/IB+B5DOrT/LjOdynlsD9DhwJoTmvnpfcdGd2+yvY1L4aB1m9OPOhnZ9T4mpQxM5
 WyEm0qLGI2BElBYXMT+z9RmWgOtgOiihRjujfS3DbQUGTIXdYfK2MZVGeWL6ZgEgL9r5
 wY6qtrtcGqEiIr7TQWHrvD9ZpkrOAgM40PiI4migtyqczMWaJGFnaSOzbYkxpl08B++u
 vEd45PaNeVjtrRLdcRyWxoDuDqcs80syuVoOCGgfyU4Nnwvk+h20V2qDHu5Ir/RAvbpQ
 pbW/7q4+KuhINhgux52vSyb4t1XKVjJ76QCdY74LPCSqihjdBy6CW9Ok7XhErGwf6op5
 JeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793877659; x=1794482459;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zXlJXj9kW6CcazbmllVYa+E4AFFo3cz96WBOI3puXq0=;
 b=T1FvWeVwNkvcaWKT/X1R2ALrgbFXNbbYB9er9aFVlVG+T9Gx39WI9Oj/ReQn96ZaL1
 FnV+Df1Hlen8y5jthSco7kn6zSw4yZbHQooqwUOYp1sjCnl+aKQpWv78l4LS8ZIFGlbc
 4JHe50dgNlwU/jwVFysTMy1PIoa7DcL5vLHxh4g2gwb+xqMXQgid01jBwru7u0i4cZ6Z
 uB1lXF0WVZlZ8n272yoWMj/0pjUkAGxBMZsTWpG6C7PzYbeAA4WFdCO13o4/k7YEOXSd
 Q4avFJZrM5IWioevcuBAkiKVVpderLnD6ky/jHfPP6+Ls9Pry1Mu3oY8tdLBxM33Z6pV
 SRIA==
X-Gm-Message-State: APuU4Z9E37ZULiTfDFKJmeWFfb+KLRTR5WRNWc64pX/+4jyfYcuIJyyb
 5xQ0c3RKZxuJJih8TC1pa8yFY50CwuuY1G9gFR9+PeCdkkl1h3qDA30rPJTtEClh5Zdr2Q/gd5b
 rL8Lgz6Zq0fnwB6qPRPbSqY+L1sGXw5R3AxCqKE0fq/x8+yGvZijNBPCrRmIDlgpZSTCQbcTFUN
 2aSlXngw==
X-Gm-Gg: AYBFou157XtQRt5Tit9G+TR7L5YKbRtJ0hZGHOQ0byyjzFd1sZ1ie4Io8B2dYiULprC
 q27nEN+bNOJD9jzktl+YEVwDJMccJJHm6rt/CrhJloW4lUlC0WbLldSiLPWz9+QMluTV1bmgpym
 scfIbmSbLdFWJCrRZ0R4vxXhOgGEXXDD6GyfagklkTWBgVkwrLeRoAAyqUtXJVLBLbejg/EBI1F
 +8N4IfWbV2yhGkrqOwwwx9DUrshgTPb1frKh/k78qqlBILSh5Xs2/D9HLuwHJni5cK9iwrZ3nJE
 kkcoJJJIWmZ5atAL3zIsBCQj7G9vHva8OXN2SHS+mVIIHk8xRJu/idar2+2y2jBKv2C449Z7vYs
 9Ty1qfCDA8TAhWPmX5ylS2SyMm0Ne1Yo8btsfxuOqY1JyOtLLmRaptA6ykeCYX7BqJo39vRwplZ
 p87v76IjVft4vNW601V97Dqd75a5ExXjkCqy+sqQltU++Ju8mUXYPDUCsYBSQCMAn1xi5Led2PZ
 6361U66JQMc3Lc3VnKpPJw/N6LHEg4sRkDmsaJV6D9Ny0NH/xsRb1BbFfyBL6WWrTR0P53t8a2q
 v7ArgiXSJQbv/MhGl10I69E/c2qB1KsxJS/N8kRq35LzC93Bo/2/yCNclGtrzqscOyrer3rKq1I
 gQOBZaE3xtVnId19b3Xdia+2LaGoZE+WT+zPJJK97KSV1tPyOnOwNBwIcNhWqNww7U9eJrX16x5
 Id5CKfkQxkLQU6vH222rCOUjFwtDtvS1RAY8A=
X-Received: by 2002:a05:600c:8b66:b0:4a3:5a91:5f61 with SMTP id
 5b1f17b1804b1-4ac1793f8ddmr432222375e9.14.1793877659302; 
 Thu, 05 Nov 2026 03:20:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed45d7f7sm9931871f8f.38.2026.11.05.03.20.58
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 03:20:58 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 11:20:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2
X-Gerrit-Change-Number: 2141
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2141?usp=email>
X-Gerrit-Commit: 58bbdfa2db1fda07c3f99eaeeaac00920b3b1626
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 11:20:57 +0000
In-Reply-To: <gerrit.1793872784000.I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2@gerrit.openvpn.net>
References: <gerrit.1793872784000.I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzODcyNzg0MDAwLkkxM2Y5ZjdkZDYxZDdhNGNjOTg2MTU1NjI5ZjZhM2M3OTJhYWFjNmQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6331709cd52e0fa33591444bb91e4b9a8a9bd5f5-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOvWk-000000001LL-0mWS
Subject: [Openvpn-devel] [L] Change in openvpn[release/2.7]: backport
 t_client.sh changes from master
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
Reply-To: frank@lichtenheld.com, openvpn-devel@lists.sourceforge.net,
 gert@greenie.muc.de
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9156980661237518739=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9156980661237518739==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EhN5zAVk4C0="; charset=UTF-8

--EhN5zAVk4C0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gert Doering=2E

Frank Lichtenheld ha=
s posted comments on this change by Gert Doering=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2141?usp=3Demail )

Change subject: backport t_client=
=2Esh changes from master
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review-2

(1 comment)

Patchset:

PS1: 
Th=
is is missing the update to update_t_client_ips=2Esh



-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: release/2=2E7
Gerrit-Change-Id: I13f9f7dd61d7a4cc986155629f6a3c7=
92aaac6d2
Gerrit-Change-Number: 2141
Gerrit-PatchSet: 1
Gerrit-Owner: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit=
-Comment-Date: Thu, 05 Nov 2026 11:20:57 +0000
Gerrit-HasComments: Yes
Gerr=
it-Has-Labels: Yes

--EhN5zAVk4C0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gert Doering=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Gert Doering=2E</p><p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141?tab=3Dcomm=
ents&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">This is missing the update to =
update_t_client_ips=2Esh</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Demail">change 214=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: release/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2141 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Thu, 05 Nov 2026 11:20:57 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: Yes </div>

</body></html>
--EhN5zAVk4C0=--


--===============9156980661237518739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9156980661237518739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9156980661237518739==--

