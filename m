Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F55606A322
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ciO9Qxqy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VSY4oKYd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NgSThDyQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ToPuqfhj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=peJmA/e99gGv75aQzlPK1e9adVldvfawuFye1YhD10s=; b=ciO9QxqyxbED0WgJ95y8TjBVpw
	wPNJcM8h2CT6ikmKTrl3qzG4opJO8nZEf5iY8Nqk8QOoQoqgUlyK9R1EyLCB+K6Y8kTnMqFMSjtBj
	SSLGjtDIdu26auMkcTmTzYSghQsr1cTrUeOWWumKz3itzBZi0YfnpRiDEf/k5KSQDL8Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVpRB-000000001xQ-1moC;
	Tue, 24 Nov 2026 12:15:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVpQr-000000001x5-0j89
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:15:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QfBM2cBivZSymjKNGJoXDtR/nypu9mWX0YnwDnoh7wI=; b=VSY4oKYdxqTrbCz87hQeW2G1eE
 XlWbQz8KAKZM8G43wayjomEEBNQL7QcQMxaMCM1xMjj+PzF4dk4MfnF4EHqj6244LxKhprvI+fS15
 6+tkBmHW6BOVmW4aGNvn6J4S/V6xyKSDw9oqEcFdtKFlrDdcBK2bGebQBgJ2OHwLyQGA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QfBM2cBivZSymjKNGJoXDtR/nypu9mWX0YnwDnoh7wI=; b=NgSThDyQAwQsvDGY8XCdZOmtGF
 GCF3Lt6TfFPkh30yYs1oOKxHrYTezDw06PnDCiG03vJ+HgVPDroqLgDmwxgN59aK2J7u3Xen4GtuO
 eZW7ejZRR0hTOuCtcGSsmVGNC11DrFHZL4OLvCXE/L7x9vCgmo/swYIwXYDvGIaFs4g0=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVpQg-000000001YX-3ZgF for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:15:26 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso48350145e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 04:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795522516; x=1796127316; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QfBM2cBivZSymjKNGJoXDtR/nypu9mWX0YnwDnoh7wI=;
 b=ToPuqfhjaq/YQPbu/6p9yj+hQ6Un1xRBEUs1phRIL45r7wee+KQSXf7/CnRt2fSui4
 BHXcBzafsnvNw2sxS+zNT1pRIK+a+bKmzyZEHQ0aOblZgDdqyg6bYUZQ2sHfE0vl0iWW
 l2PYZEm6QNjcfTc1IhSmNgfLqbmnmtOJM30zFgvXV4JhWCAV/ITVU7EYYbB+YPAsS0aJ
 iyFa0iIhp1URCwC8vriFee97Baq1mr31A1FFN4IGMKFybUTe+BhEjFc7lLBFx/GvMrlS
 Dj5AtdJlDHV21k82tWAvPJd0CIqtntGo0cWh9ZXYfcIyt4B4UKtxlOxXgFdw9PnchCaK
 qhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795522516; x=1796127316;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QfBM2cBivZSymjKNGJoXDtR/nypu9mWX0YnwDnoh7wI=;
 b=u4WiFdvnzUmOTa21wN/X1dWMjmnoNLK+QVMKIrQXR1d81FRGWPjJZusw7Fa77utDQ+
 cg9wRWnjRA32r9ho97NyacEfr3uqeEIBDLCmtEMVZLe6BqTWqoX+xWo4i9txN6k3TeOZ
 AF4coYKvi29BYwOPnXlPcOyEkr5Ic50L3mFKt5ceHEt56Gl0CM/sXOcMClE9zcmn6j4x
 FDsJRLTM/CGd1jToQYItxu6BG2QeGHUoESNjt2Xq/aXlwv0E9XGs9F6wyOjEQ3CLXCPi
 ZIbB2wsghWtiQz8G7P8FimV/qr8B+R9kFW8//JnbXEv5eip2tbe0JF5eY2Z+HLnv72lP
 BWfg==
X-Forwarded-Encrypted: i=1;
 AL+hErFF9D5+UAyIsvZkl5a29S0698Fl97mhTc+o7itMAVDAyFtGi2aDWXwzCJmZMB9r6rTQRgvkY1pw8qDYAuvi@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+RLv/QuEHcPsrjUPdw6OsXv+fHg9e7pLXovsjOQPVrwu5dbflC
 CXIgEMLsp7E0nuqQlVuQkL5AEN2QdN6PIu9pGzhU+4ixYeMiih6svxR04Bqw78/8HtUvbgIjTjy
 vCYjYu2NkizkvCwQ5GnuSI8E47v6z+aGXRlPR065u+HuImp1RKqC2VhxvNyyZAbEVLK7I
X-Gm-Gg: AZFdTZfm8g0smHzvoMumuHk9KqVneVoUi6Y009eVXcJqL6Ji0X4PNoIwrCHPgzZU1I2
 2xmTL70RyMzhvwz/6azPota78KgyKrwL8msA9VT2cSylGbDlGtW8rbrWHQVBh4vopwkh6mB4dDJ
 dYZHcQGUBQA/ysOwkPRMpD1QRYc912xwSNgr5sDrW5AjRthQl3Xa2LaToZpzRLFzP3EbUeTIlXm
 jxqA+FWAfooPhC/64tE6k/K6UdYt/9bKMnq5lvltd+DdKX9mhp5BB1+CgLOETi7pzVFCS39KlVk
 gUJDKCTLHqrBpc6RJLOjZ+4SR69rd662QFxqQiiNJQSlNcaQYCCEzmSQTIDFQJaYwsSwka/cgAK
 csZ38v6eOVZitGOrUiFHVm6ZC3Z9zEFtJMhQ+eBnx29ZPwKxTuszne4OPYrNTwYZ/8Ejp24NilF
 lpYo4ecZPI6VtkFZV9kbMD7YxWNEtczUAmOlf/GPNC7iov4OpgTfIgXaUTmf/pbJSWoRMPnHyyG
 oQfKhGq14XhJXwpUtTF0L84nL9acOceOYw7URLSqeX7hzWDMIB3kbFAXNn8ZASdQs91lMRGFF1C
 yDvbVUBeuQH1qSbvevOwugutKYWry2s1oJNpeLkIWQfrezbZKa7Lzpa2w4259fn8rxhwPYkeUGe
 mmP3DtiQFSQTWvfHnhSxDASum2IicV10xoqPloWoq95S44os3QoTIr2nwxqjQFcJVR9l2S+wCJK
 gJWHwOu2I8Hb0W2qs=
X-Received: by 2002:a05:600c:37c6:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4bb88812a84mr294621495e9.13.1795522516182; 
 Tue, 24 Nov 2026 04:15:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906c089dsm229164885e9.1.2026.11.24.04.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 04:15:15 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 12:15:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7b13d8b5e0babb697191e21adf2998a090c310f4
X-Gerrit-Change-Number: 2335
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2335?usp=email>
X-Gerrit-Commit: 7d9c20fb97390ea1397d58c125d176388dbf9035
X-Gerrit-Comment-Date: Tue, 24 Nov 2026 12:15:14 +0000
In-Reply-To: <gerrit.1795515967000.I7b13d8b5e0babb697191e21adf2998a090c310f4@gerrit.openvpn.net>
References: <gerrit.1795515967000.I7b13d8b5e0babb697191e21adf2998a090c310f4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE1OTY3MDAwLkk3YjEzZDhiNWUwYmFiYjY5NzE5MWUyMWFkZjI5OThhMDkwYzMxMGY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <56d9339e455d81eded3cc236aa53aef12104a090-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xVpQg-000000001YX-3ZgF
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_win: use CM_*
 case labels when switching on context mode
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2365067488191318718=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2365067488191318718==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X5dnxjnPV64="; charset=UTF-8

--X5dnxjnPV64=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2335?usp=3Demail )

Change subject: dco_wi=
n: use CM_* case labels when switching on context mode
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

Thanks, those tw=
o are already fixed in https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2332=2E

=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7b13d8b5e0babb6971=
91e21adf2998a090c310f4
Gerrit-Change-Number: 2335
Gerrit-PatchSet: 1
Gerrit=
-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipak=
ov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Tue, 24 Nov 2026 12:15:14 +0000
Gerrit-HasComments: No
Gerrit=
-Has-Labels: No

--X5dnxjnPV64=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Thanks, those two=
 are already fixed in https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2332=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335?usp=3Demail"=
>View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To =
view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335?usp=
=3Demail">change 2335</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2335?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I7b13d8b5e0babb697191e21adf2998a090c310f4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2335 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipako=
v &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Tue, 24 Nov 2026 12:15:14 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No <=
/div>

</body></html>
--X5dnxjnPV64=--


--===============2365067488191318718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2365067488191318718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2365067488191318718==--

