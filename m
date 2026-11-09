Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549E606A335
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EMutbn4w;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jU/phiVK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gbBSzjhf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=H7qQxErD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fnX7Gt+mCByNfVpVdcaSkHTYFnn5M7nEaVp42w6FQm8=; b=EMutbn4w2QVpXCo/vBbdKrvMsc
	mmFbxGegIQm0xRf/yzN8BMF7GybGV+edXNkvdRPHXM1ajMcGYG73RSitvjuqUBOs4mKwoZ1WqBFdY
	eCQ6h/z3lEyHv06bhl9ys5qp00q91SaOOKPPWKEJgULn7w9PTSdnqA8pHRF5gCZGRrDU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQLFO-000000006ho-1g4x;
	Mon, 09 Nov 2026 09:01:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQLFN-000000006hT-37wY
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 09:01:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mhxR6l3kMPeRUpwAx61C8/P2M1wx3iPGgweEGpYmQB8=; b=jU/phiVKpqVmbMKKPJFimIds3V
 rW+2jSxj31ulwpnAMiiiWVi81BIZP3QSpQyK0RpB64lzsiRupMjLCZjI9bQdKPMDrOFAzb88+ABYy
 hHOa5SJpqfaVVzJVrceQZMaGwqKjqijLcwLIloJKJrx240WA+5spHYUJ/8iAW59uaeUo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mhxR6l3kMPeRUpwAx61C8/P2M1wx3iPGgweEGpYmQB8=; b=gbBSzjhfZZ7cqzys96wurqDPXb
 qhK4P1WLRbScoC5/VL8PQQTjDOpRp2iIjTkqwefoT6NB5CqmStEUTs5j4Mg4JmTnKJJO5ZcTPWwKC
 uM4Oi3e4Dyj9o2xhb2+t7Xw7ZjqM+kwIZfIKP96AJr0xn1xXerF8aLsd2SKqR0TOV5Mo=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQLFL-00000000124-2q2O for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 09:01:01 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so4632695e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 01:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794214853; x=1794819653; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mhxR6l3kMPeRUpwAx61C8/P2M1wx3iPGgweEGpYmQB8=;
 b=H7qQxErDUxLV2uAA1hxUXHMpfKD6GCD71sy1NBWXc9YPnHy/Vu+/1O35VHBtkxYJ8J
 hBGBUCJh2gEpOItWUXK9NMnYHEkp3TCb3bDAIl5KSBH9z8Wnxal345g68GPQ83lBXzyF
 7tB/NJCUshA5KN8umAj4F6u9hYnWlob5FwYwyL3j2GrrkOO+UF5a8hHXA5qbXS47vKUe
 6waTxgP7IR5x5cUJYxmYtqTw5ptvXTHUn8oS+9y59NQ1+L3ZftHIBSBc4q4cqJOI9Tv1
 3NDyOJIbNYp74fdTqBhn2iZM3xAaWwtEzaW7rJ1Uh4XHDnzY8t/VOeMCg29WJom/e51b
 9Y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794214853; x=1794819653;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mhxR6l3kMPeRUpwAx61C8/P2M1wx3iPGgweEGpYmQB8=;
 b=xpBqbL30sS+AqbUC0PjJwtXFL+Lx8aQ6lSCopMarWaQJgJo5KB+jSrTQTEhGkPe6LE
 FTmMYk7qG2lAgNUeXJQ+suN4uwX+J9eKrCySLvSZOhtU9wmCAcwAgG5z+Xf0LzEjPfIk
 Xw59+BT+2WiwbDA8+OktjeI3tlS7djiW35uWzRQy3lFwN/TcsDOjACl76Tz/KgHqD2rP
 SMUijvk6EknK3oXGWLgiwOnJtPC28mVyyJw8MixPT0xfmztFTknbLBL6wcLbRt+8MrmZ
 Ie9chfYfvHV/vuYmz7hZ7jcQ8r6fmDUCjKaTAwgi3dhKuyL4+0RGgKpjSHGFLbXZ80tB
 7Gow==
X-Forwarded-Encrypted: i=1;
 AL+hErGtNX4+7jGJcAIqInR7lUqjj5zNfGxWqrQgzRnH5F34q+SFyFbHC8NijU6wU/h0QPk4f0cTfbIpM5GdkgcX@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+9cAfM6TbohM6lh9MDa57pJkN4FqCpQfCLZeznLlzQQzrU92xM
 9PAq7kBxHIYNUQqLSYuzw3DmAfDyaZy8T7VPov91X4SgTXb5tSMvTVUk67w+Zb59YcDUMDXBRpM
 F9vp4RKRsll5zMA7Yz7KipomFbde58HtoNb6lsdrI//brEjbLKuunEgQZVXcQCgYqoq0Npg60yF
 gxpbzkEg==
X-Gm-Gg: AYBFou3Y+lVDNzD/LmAd9X2W+QStahB6i7hTXxeOQGmeBQwCLv3S+xSCe/3GBt1XuWg
 NaN7r+czrPsujUTWk7XEoQJnL+ZT4YBWhGDcXXSqBZIQToKPqg47XAhh+XHqW045one/iy/VYt0
 mbaH3qScoCdHt7+roGCElQRKvaWIdvPaiOlsAQYLn4//YghTCV47gv+6bZ7kdHQ/HUq14SXDb3s
 oK/+IdSkRH6oXb0o/Qmx/ofRMa1/R7Q5k6IkO25ku+fPA/iB1rKakW61hXZ7nzsKkW4qyu2Gvo+
 fFElk/8wISyCtqbI5C71GhFaSE0jjH90T9AJqb7vPG06ypDKRnmVOQ5WuNK3P3/slBKzHssCbJB
 eHo7jp6XNqC6lMDc5hcpN4TPKg1CBxATYmzvhUFZnxT3QdQYoMBQWsYwGNRYWxMPqI9FdyZLhHC
 aW2VSxRe1rgyoaVM5MREcMLe0xGvh+UugoUYfiOAne7ehaB7qj42jtfFW757IClGhb/BIDDVY4o
 diofvOrzMOCCYMnyTK+MKJgjnEXJqmmdxtWMiZ5iMLWa78zFiSshIlNShJl8RJmO0iLTBzfdUf6
 73LhYdsv9Y3Eq3UxO/wtKFpOn5gwK1Gr+kXkKyTbCFqAaGVOPotNC8eJrC74Sj+mx/MFlEWM59E
 cTiFlIBu9TjQ+TFh55DOFNcZ7QfZZSflVjC2C6Lv2ycdmXZNjASEsKw8w20+JbQt+HLeDO5XGNG
 c4MFUP8hggX2/u/g==
X-Received: by 2002:a05:600c:314a:b0:4a5:26b8:4507 with SMTP id
 5b1f17b1804b1-4b963c74205mr65551185e9.21.1794214852909; 
 Mon, 09 Nov 2026 01:00:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4959755d423sm8618993f8f.40.2026.11.09.01.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 01:00:51 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 09:00:43 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc
X-Gerrit-Change-Number: 2146
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2146?usp=email>
X-Gerrit-Commit: 9067f9bb8aaf22415cd231537f59353095b8143b
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 09:00:43 +0000
In-Reply-To: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
References: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTcwMjAxMDAwLkllZDllMzZkNDViMzBhODg2MTBjYWZlZTY2OGVjZWZhOThiMjllZGRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a8862197fe388f4f6a3456bd969249490ee90ed6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQLFL-00000000124-2q2O
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: reflect_filter:
 initialise warning_displayed in the rate limiter
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
Content-Type: multipart/mixed; boundary="===============0330201976427597259=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0330201976427597259==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="47sMoKqkTXs="; charset=UTF-8

--47sMoKqkTXs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Lev Stipakov=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Lev Stipakov=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail )

Change subject=
: reflect_filter: initialise warning_displayed in the rate limiter
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
46?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ied9e36d4=
5b30a88610cafee668ecefa98b29eddc
Gerrit-Change-Number: 2146
Gerrit-PatchSet=
: 2
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Ge=
rrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Da=
te: Mon, 09 Nov 2026 09:00:43 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--47sMoKqkTXs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Lev Stipakov=2E </p>
<p>R=C4=83zvan Coj=
ocaru has posted comments on this change by Lev Stipakov=2E</p><p>Patch set=
 2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px;=
 padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail">View Cha=
nge</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail">=
change 2146</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/214=
6?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 2146 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Sti=
pakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Mon, 09 Nov 2026 09:00:43 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels=
: Yes </div>

</body></html>
--47sMoKqkTXs=--


--===============0330201976427597259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0330201976427597259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0330201976427597259==--

