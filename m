Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1731606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=i5in/V+2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ctP/h1dP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e4kib0ep;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YohRB3lH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HOCWwnUEOxP0R6UUZtglspbCJ/92n+HdWRd6FNzwZJk=; b=i5in/V+2IUff78hYOrl81Tv7H1
	9r2ZUXgqhLqIN19ppjkVXzDhpSrGgqBmDRtSAxPB/d2EzgsXzF86IpDeSBqmUCexSvJHlajhkrcJ4
	0TlKdZvRGEhMZBjojMRs4LZX3cadXn6pehyc1f5qGUlJtMdfMQVPzn+uO+k0cGeEkyGo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQS5o-000000001Cw-2mAB;
	Mon, 09 Nov 2026 16:19:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQS5m-000000001Cn-3xvJ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 16:19:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S0oy5/6YcKGsADKC2i6l7uB7G3cLX8eAYU4ysNRpdTU=; b=ctP/h1dPkCQnb4/I6tK3ROZs6y
 U/SAghstP5znZBXf9bF9mNBp0LWEO58Ji+5hYzwuLt0Bk9Ync18qKui5m1wNtlaHObWuPnIA1VLyN
 U0YLCG9vjJqT4qeLaDm0pih5mXVe4WoxDS1u2pA0GT5ujeBqdsbuFVl54wM0DOWMGfCw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S0oy5/6YcKGsADKC2i6l7uB7G3cLX8eAYU4ysNRpdTU=; b=e4kib0epT1Syu03fEPyQJiEB31
 Kg7PSvNLzz/IN3PxhURucjiowQ9iBGtNY1+NRoE+NvPbX4pisY0fuB2rOxTal/H2LaFiQgO2sK2vi
 riub89zhNL48sRZBeIpVc6F3MlkitMwuDAWrgh/CRMVAQfV71ndlPf46eN1vsw/0VFEM=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQS5l-000000002GO-1bxZ for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 16:19:34 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so11508725e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 08:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794241167; x=1794845967; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S0oy5/6YcKGsADKC2i6l7uB7G3cLX8eAYU4ysNRpdTU=;
 b=YohRB3lHvqplKNgu/LjDkxCccmqP5NQSiUAN6zpAh5pq3dp3fGTXkH3PuubD4mGIFk
 BLTOgVdMznGY09OOpU4N/BzOFw81kRrCxUyEdxr4rgF1UdWFei4VyCijC6hm0fmdObaY
 tO0O1BzUyO8r+B6zaCp4Cs1jBapLPSiSU64E4K2SDgAOIElDh7faQ7+VC12Ckfew7VMm
 1r3wnfHEWDMRybJLVAhrwq3QarIF0iAyXcnfO6NxwW2uMDcG3zg5QqQbP5a295LgD1IJ
 6/MFXTqILPpI2nNPtX8iRIRYPnPVsOzlddW+UpAMUdRIYkY2GBmgM4m4PKHD3gvrLR9p
 Lqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794241167; x=1794845967;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S0oy5/6YcKGsADKC2i6l7uB7G3cLX8eAYU4ysNRpdTU=;
 b=WSW+tBNJwQo5FzlxBvTFCfFWKQC4RO8Uy3u5UNmqd/Z+4jHWjYotK4fbTZavY2pTPN
 JIyK47OaQqiYtc4aeosYNDbQj1wzb6pSW4sXz5Gf3RuMfjOjnKUW6Wxgra5WYHOUdxoo
 4zlbrxd11qahBDNNDs1b37ETbI8ZG/P1eltdpPTyfl5eG+n4gwxJxGXW9sCasLoF9g4H
 Wfqq0HTPSRPWl6I/eA00r+/ZrUl9yEE1RjojONycoovLZNgNXPErNCxmiHlY9P784bic
 F8ua+uIdvhVjcTJ0GY/3+eznIBcKx9gpljK3B07XyP0+Ra80+LJNaoyDkr/c4mybsFco
 MOnw==
X-Forwarded-Encrypted: i=1;
 AL+hErFHXU2ThDDEg5SAKOo7w0lLQQNqJeVW1CyjpuelLRums7rfMy7VtfAxKneAY0uQiui63fJfX7AnV3P1G0Qo@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+pqwf9JpODHxFJ7CAi/D5IPVCRLAsZHGQAvDRchxJWNWaJLzON
 hy/eEK3eZ/fMHYYfWOKn1GcU9c2EgZBrT6XoPf2r816JKTa7PNYOh5FEZM81rR57LltrZ4jwNfd
 f21IfTVhbfZIevcWvhAEsbRXycrxFFo3xNkE9qN3ejDsf5+8QBpE5rSShPyPJUdE9EA+3h+BvRD
 zCuGQY3A==
X-Gm-Gg: AYBFou1Lt5mgF+zYaSmxJnwu5yqoHu+n3oQFqy0IqRNrggfAYo5/CgqRb3KjmhYRfaZ
 CrT1TD0fAmCwkjYunNuPZpjdYnNb5iT+jgQww+sBsVR2haJTOxtlEmD7w7yPQokj05vL6hwGkhw
 dimq+Ml7tb67XY21hwdVMigmydjGYdPeLdmJrFPXz6bo3yACq36Vb+zLNF1Cy789x4OFv/oL192
 gC/QpbQEWHBSiIrQa5RG5gxoTZgnnS+gqQjidUiKQ52AGSPUHb2EN6ruoCPk5JVqxNXrlMkw8x7
 3knTm1zm5wp/XXjpbDlt0C7904EH31ycPHoQKm59FFcInxaCzvQwFSRJmbfvytGWupS2ZGCyevN
 blME4xrSsWnrN/RjovHDgDPfOCuAQXBGcnnG0ElHL/WaHhgF6V5D1FMpzeeHISyLaOh5kMcxbvf
 l9arZjPMUJI1cYtuoTX3eJXcDRt9MnYmuxtbUMHJdXDmbb1GPMsVe8EyFuUlTXvIVowj8wyu3bo
 iD48L2oR221Z8tp0Sno1Wu9/iZNEhH7eXV9DcAxBMVj+4Hti45Gtw7KIuxLBfOn5F9/eO8W/jxk
 xgQwvjxragYsa5DdWg1tVVHoOuVlJb42f47I3c9QG1P7obM2h0ZhhF6tLmLfTDoj3Ynw1UxWpDf
 Ko825m+GJ4E4Wxwm7kvUKris98H08YCaO6mHzAbIodoT/x+FW4CUn5P8+rYY+An192B2NWlHAdL
 Il7c9UsRFH7RihPQ==
X-Received: by 2002:a05:600c:6990:b0:4b3:8529:eb27 with SMTP id
 5b1f17b1804b1-4b963c97d71mr77590945e9.27.1794241166466; 
 Mon, 09 Nov 2026 08:19:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b79502652csm168402645e9.4.2026.11.09.08.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:19:26 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 16:19:24 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
X-Gerrit-Change-Number: 2001
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2001?usp=email>
X-Gerrit-Commit: f1a053fdd74d6cb4a723614dbbed995c8f916c58
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 16:19:24 +0000
In-Reply-To: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
References: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMTI4Mzg3MDAwLkkwODllNWI3OTYwMGM1MzVlM2MwYzVkMWJiMTQzMTlhYzAzZjQxNDRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e4ac1d6b6387b30a3f09e514c317295e9c5a4d3c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQS5l-000000002GO-1bxZ
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: openvpnserv: add
 automatic service again
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 selva.nair@gmail.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, lstipakov@gmail.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2077232871345748269=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2077232871345748269==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="80rlXUsgcFw="; charset=UTF-8

--80rlXUsgcFw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, Selva Nair=2E

Heiko Hund has posted comments on this change by H=
eiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail =
)

Change subject: openvpnserv: add automatic service again
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(2 comments)
=

File src/openvpnserv/automatic=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2001/comment/88719c5e_05597525?usp=3Demail :
PS3, Line 113:  * @param=
 pos   [in,out] position in the buffer in wide characters
> @param[in,out]
=
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001/comment/f1441ab5_4fe=
3d24d?usp=3Demail :
PS3, Line 858:  * The interactive service lets NT SERVI=
CE\\<ovpn_service_user> start OpenVPN
> This breaks the doxygen build in bu=
ildbot [=E2=80=A6]
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2001?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
Gerrit-Change-Number: 2001=

Gerrit-PatchSet: 4
Gerrit-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Lev Stipakov=
 <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Selva Nair <selva=2Enair@gmail=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Attention: Lev =
Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Mon, 09 Nov 2026 16:19:24 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>

--80rlXUsgcFw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, Selva =
Nair=2E </p>
<p>Heiko Hund has posted comments on this change by Heiko Hund=
=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3D=
email">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/a=
utomatic=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001/comment/88719c5e_05597525?=
usp=3Demail">Patch Set #3, Line 113:</a> <code style=3D"font-family:monospa=
ce,monospace"> * @param pos   [in,out] position in the buffer in wide chara=
cters</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">@param[in,out]</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001/comment/f1441a=
b5_4fe3d24d?usp=3Demail">Patch Set #3, Line 858:</a> <code style=3D"font-fa=
mily:monospace,monospace"> * The interactive service lets NT SERVICE\\&lt;o=
vpn_service_user&gt; start OpenVPN</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This breaks the do=
xygen build in buildbot [=E2=80=A6]</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li=
></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2001?usp=3Demail">change 2001</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2001?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2001 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Selva Nair &lt;selva=2Enair@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@g=
mail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 09 Nov 2026 16:19=
:24 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"d=
isplay:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>

</body></html>
--80rlXUsgcFw=--


--===============2077232871345748269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2077232871345748269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2077232871345748269==--

