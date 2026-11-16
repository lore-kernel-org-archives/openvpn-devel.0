Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6780606A322
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=G1x5vbDS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=htJ/cMup;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kyGq7Iab;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bxL8YEd9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=76AUewAKRtcDm9475zVszcURX9Rr33e4UYIVnePPkMc=; b=G1x5vbDSeDlcRCb9sxJMEcA553
	S/KuF/P7OMgATTdTLksIAsGFVzmQQWlDa1kkKpdoA4yUUsmbtOarm4+c1YW1+OrbOLSbGWo4WJDAo
	z/vzX1PnEbnWu6VyQFu7HyH/vCPzzWJHzXT7Y6a2XeMR6NvkvEn11J1x1tkcvUlaEzjQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT0bV-0000000066V-0RJw;
	Mon, 16 Nov 2026 17:34:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT0bU-0000000066P-1foi
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:34:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kqzcQsfnFUbXmQWAJfx18W7SqrCTdAEV1/nx0Bs+P5c=; b=htJ/cMupd9CC7UGHDtYVdtPYV0
 GTHVBLGQeIUJgzlnGI44mlpGKLOqEqEhfLz+NJfWRTCRbuXCPlJEd2wlFsUipbH/e9UdpXbay7ZGR
 cIRk/xkxOU4hNkUFGUcwcxioZprWe3CmHnV3RNBE9f3ZnhMWDsn3rVaaHD0hf7aZrgcc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kqzcQsfnFUbXmQWAJfx18W7SqrCTdAEV1/nx0Bs+P5c=; b=kyGq7IabBTv7Q4CuNqxXoO3X5t
 OgZRMRJtw/OeD2yIBsmxYkWKRPEAJLEOegN2givvabtFY6BOTGn68Sk61cgfpUEIuyI/bEFEXNyk8
 3iugOuZNGkQXOEchbAbZRHYh7bJZ3BjKeXCk130UEA/LNmX7hKGdsPJzuEUzak/LzRHw=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT0bR-000000004yK-3IUO for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:34:52 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so12355285e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 09:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794850483; x=1795455283; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kqzcQsfnFUbXmQWAJfx18W7SqrCTdAEV1/nx0Bs+P5c=;
 b=bxL8YEd9t+2jgVxi0O8Iwd8qz20tSidvqqfsPLp5YO5eTxr74OR2ZJh54NgkOjC0Zm
 PzTnVTrEs3ja/v/gej/PrAVT4nj9kLyuS9ojBJAkh6VXtV0Fwdzz49SaS1FHmV811Ijj
 c9ZV0EGMKpHHsMwaWE3uVEVYcmWSZiP8vXxOkw1SJbVCDkueQIbIf9f4ffHL3ZhSww0B
 73GWLdx9WTZe2uyesqbATL/QQ3+eh9oJ6HJAx8SLFXYe8tYBpzsbna6IoKIWt0zOGN7K
 aM91Aj3HaR+x1TyW789dgAkO09jFy4rB/jC8bCS2g1JnIdIX4xaujjHRSFswHvfL3fk0
 MpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794850483; x=1795455283;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kqzcQsfnFUbXmQWAJfx18W7SqrCTdAEV1/nx0Bs+P5c=;
 b=DpBNoYhshxWBFjRQKtKME+0wGiy5y13AC3xW5SRq8o0wLY0u5ZxUkQS2/k3DnTssAD
 f5rUroCv3rr8J1EIBR8374f7gKLEB/1XlkM+XNbniygK8UwwiTvow39O8rB97DC+0OXK
 cKFob9DaAj/xynmBp3G26HmdO2BecudEt+hj84n1xARyd9g2husyIvyUvChMf4FN3F4Y
 G+nYLbYjdeNd4RtIEN9NoGBpvL2yXqzXOYCNEpb+20wTmfrR9niGN6CWzbqT3FNV5jUW
 ZMfEMiHASz2tDL76DFe5G2Wdlvyo2lJ8LnHlRCiORuLtBEzJ8Xg3yxorGsGKo0GRtVXs
 BYag==
X-Forwarded-Encrypted: i=1;
 AL+hErGgUH1mSufjLAyGnKH7S2y4xHRGzA7wcn943GL+I/jC/VoDg7xZVTfZ1a0prrcVGgZunuDdCKecjxJ7rCKJ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+JTO/5pZv7bGvO0B6r7l0BdHN7xfDl2Dtme2gopqQ8ewcwa/NY
 hbTXFSgB51k2+1ngJgES+D1sMtLTtbJwyL34k+Ww4ezm7y7jOsfmb9h/hF/voSfNEqY+ngnmJ4/
 ARrdGnbAxXy9gdT7lV0Jbt6x53evqz7v1yW64OvtGg6IJVveYxvg//GmE0YWgnVLHxaL8
X-Gm-Gg: AYBFou2meNJnC+AWkfcFgQMJdvdrqGDZpvtNJGlYet1hdT4Tkz1vd9gYPrYxrlIrACp
 txAgUmeQMMILIRXvh8JeuhBQBIxYoTasfnq0+T4FSDZ0L4Xk3sVMxZsSK620BZFsf+ilZBFNpOE
 3nPnnEMpeBmlj40xzXCRlDGUGmjhpWjFsIc6YL6RDutnkxG6IlCaHJQUQs2ymIgrsPY4ywr0I94
 k6fK6UnkZRnR++sS/MA8ALRwnH4IMg9UJTDlVDGsSlmHK45lvkMSXxwwuIl/qUCF8KmsJjONliB
 NxoXRKQJJsOgrXzwsQvSqvqfrbTAidVpAE3q1V73CRMeQwJD7ZLdQnnTjCywH+DtWNnrKJk0aom
 eAddnClYBNExgwqtGWcfIAnxidYkFJEp57RAQkJ+LYKj3bPzOZqKjvnp5WF9F5pcc/xfP3i8lSI
 qLuvzNRvM/WaSQSctBe7rkJCdLFFutol7adoNJvo8StgTEPF845tv3rxfJgx63AJoCyFbQbVAeD
 guSUMRH6fws+B7jqCISLYftgtADQz6pjuLGaeQZSXmjU9e16nykaNZE+zolvTxo8o/AJ+W0exOm
 iytzvMTRej32cJ1/5bflVG6MoeP/qyjmFz+smLOruEpTBe02C29gA8zxSKIAgcscqQtDJ6ixSYg
 3P2aI0VIPRuqMzlpW+5l/N9VrE3r55jyoWFIzSyxII8uPoT4Kb0pGxIfzeJi8irqFcfy+3z1mZI
 h/+auZZLrbvDmkv/0=
X-Received: by 2002:a7b:ce9a:0:b0:4a2:392:9de2 with SMTP id
 5b1f17b1804b1-4bb55a911aemr158486505e9.28.1794850482916; 
 Mon, 16 Nov 2026 09:34:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8220sm3031485e9.5.2026.11.16.09.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:34:42 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 17:34:41 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I604fdff9c0a7cbbddfd025a72e6f19a96bb51753
X-Gerrit-Change-Number: 2190
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2190?usp=email>
X-Gerrit-Commit: 1eee0127ca247ea7afaa47468ee3c9b902ffecd3
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 17:34:41 +0000
In-Reply-To: <gerrit.1794828082000.I604fdff9c0a7cbbddfd025a72e6f19a96bb51753@gerrit.openvpn.net>
References: <gerrit.1794828082000.I604fdff9c0a7cbbddfd025a72e6f19a96bb51753@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODI4MDgyMDAwLkk2MDRmZGZmOWMwYTdjYmJkZGZkMDI1YTcyZTZmMTlhOTZiYjUxNzUzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c398043b9c8bf1f885bcc6f63de676b6af3d7a59-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT0bR-000000004yK-3IUO
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto: drop
 redundant epoch assignments
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
Content-Type: multipart/mixed; boundary="===============7678267008280045485=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7678267008280045485==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+Qws5/kaKiw="; charset=UTF-8

--+Qws5/kaKiw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2190?usp=3Demail )

Cha=
nge subject: crypto: drop redundant epoch assignments
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2190?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I604fdff9c0a7cbbddfd025a=
72e6f19a96bb51753
Gerrit-Change-Number: 2190
Gerrit-PatchSet: 1
Gerrit-Owne=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Da=
te: Mon, 16 Nov 2026 17:34:41 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--+Qws5/kaKiw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2190?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2190?=
usp=3Demail">change 2190</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2190?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I604fdff9c0a7cbbddfd025a72e6f19a96bb51753 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2190 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Mon, 16 Nov 2026 17:34:41 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--+Qws5/kaKiw=--


--===============7678267008280045485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7678267008280045485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7678267008280045485==--

