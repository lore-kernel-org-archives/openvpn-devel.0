Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9582606A324
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j2QOZgy+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a2APexKa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Rf4v2NQW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Jnn0xqUe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wj59CPNgDbjaDAq8ouKtTHl1VQawXsZfB9wgEOJ/VJY=; b=j2QOZgy+bepZfwx8OBLiuAfThz
	JWh86K6trSWVCbYIqie1vM6FF7jiVq2iOmVWhDz+XQFRLkCrkhMjHxmJsQ187oEJF5x5jN/56PVQs
	pmEzU+L46+gVciNZ+/dxE4HlLgXc48Al38NRHetNCF1DgL+uVoZNCNSOk8uOsqg2xmAQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4XY-000000003Db-434f;
	Wed, 11 Nov 2026 09:22:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR4XX-000000003DK-2IVX
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ghQVSL63otFEPsym2CL6ARIyVpJlBD6RCe+wKaCHIgk=; b=a2APexKaAH6k2BWk0j1vqsPTfN
 JtZU6nmghj0GGhY1N4sSQxqW4sRF0pDlIfEYkNl4vBO5Z8ZfVhQFQyyOXkZFP6xpIBp83ksc5gbig
 c/M72QeZI5jxndCntkFb57tIFhQ95Marzukb+mmLXxRqNmvaZW38DEKNLS3f7UgHueDc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ghQVSL63otFEPsym2CL6ARIyVpJlBD6RCe+wKaCHIgk=; b=Rf4v2NQW2mIqrSNDuMKuIDHxye
 2frNVrPYkJZGWqPWL9wq6B5HbMkIm+cSri3RZqiwxhX3wOBs3OM6WU0UpbypuVQ85EisHTIiGLfOO
 fK3UprI98365X/GMBU9PcYQgoUv+3uuky0AnsBk5yFtEzMJQutA+PgIKLe3PMEVIZnvA=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR4XV-000000000GE-3tK0 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:22:47 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-491971ac844so2795814f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 01:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794388959; x=1794993759; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ghQVSL63otFEPsym2CL6ARIyVpJlBD6RCe+wKaCHIgk=;
 b=Jnn0xqUeLn8DaXo9huIhw2DLZgW06udZi+1WG93olMZuztiYJEOraqAmffm0UgG3C1
 ymDLFVdGef3EoT9GCPPXfddC1mq9Hw34xhMABH66I+J6HIW2LmeYehsSjEu7NvLxxyID
 6tEMtk7Gq+n7fKI0UFD0xZKL5kJ9agT9lRjPGA8UkGKgF2UKYaSASTKl6iqWIYw3qS2R
 AkTfV3a5hMqceUfgvMOBsVhTWvzRjV7u4CFP4ns+WSSgS8c0+fAjxtLtj1RkSA0Lr2qB
 AsQedPDSmjzabDK057L2T2O+t4Uw1uwOgk/v4XMqTqrwUvDVVSYzACwbkqjIKAJk6hLO
 U/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388959; x=1794993759;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ghQVSL63otFEPsym2CL6ARIyVpJlBD6RCe+wKaCHIgk=;
 b=frgp2s0aTQ69nGSoIMjBRBufuRuVCUqd5o5Gk1ImOdScbBdQN0SOfEqk/uUhYX79LP
 nvhM/6p6CKiFjfj2boF8QumK6XijVFRBTU5eGbhwK85H919UV+0dWC6bt/TYwWkuMNgU
 gDsHkY6ATzhbiM1uM84aRd9vTNoVeZ4IkxPGGsZr+FDylbxM+VGMeHCLm/1mIRzef146
 jC1SRNOka37daf2PRksaJX3KUYVR02v4h3fm5ROjollAL6FXptS/CFFijY44TPSm4zvV
 9an+qtnAWLyU2lLhtJ39zTeWT8P0VsYTX9i+ShcM5wimMyoV/n94358VXLNbN3PnWisH
 VHUw==
X-Forwarded-Encrypted: i=1;
 AL+hErHqL9f06HuJzFwWhHuUQaPr1B9YoqZtZubPMtTrSV5by3YAi+gg6fdIq+eh9xuDsU7U5x6f+ATvg7/vfRwG@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9QX/iKCHsDanxqCGS4Aly+2UJ9TvtHFHW2SYBGg8gFnR35x+9M
 3idNcai05vETcADI9sxW2PuzxQwG67tCCpSndwzyUCBXKBYAD2rstYjIzdFqmPVXxC7zzzizOv/
 j1Tg+VmKWR1bU4MopvkiFkwfm8jeURXtGFLvEfC2w+ujHoRdHkeIn69QYSOOiijDtHq9uqVwN7d
 TMZWBZIQ==
X-Gm-Gg: AYBFou3J7RRkviaps23r0h0Z4buZ8ExmnfI/ReLY8rFaJ7AvOegvnW6ZMQitDio8BMM
 MENZ+jJxFirJRWtEj14/o8d04aIZ+cuuAYY3Go2SPf1P49d1BGzB+A2chsNFg8F8wLJkpW7oedQ
 NJUDu/2m/ayAysk0gDOcw24G9z9wbME+y1MKG3PYvIM7H9BtOcJvR34wm17kaPVPbhYy3K/fMAz
 tSHgIAeMOer5L97fCRVKYqXa6vYFHLrlGfv+NcGaRpkt2XOnuer5f0Q5gqNCG7NLsacCaw++gIR
 Y1pSPV6C+vKJwT68pYEW+FM5iFIST/3PpVa4XWiMZLMq5+pFe0PLrEdf99elbVSssFTI3ySc+iR
 Sbaz3kEzFFsiyg4QthtGRpFwiq7EWEXx3jJv223z2MBIO7npoI5FSYJ3c0X2yl3bOpooUI0q93n
 9kJR1WSvd9WIv9gWATmdLJsurWbzgUpF4g/8uyQ/5QRQBIRQhARxZ86THzmKV9YywwKbGn+lA3i
 etPQ+0wt/CvkxLxcrLctgV6MN2wGlv0az5yiiwOlQduTzlTWfPi6xRI0f/1Z/h3uiVq/ozr5TSn
 wW3EK267Q2OUvucyuwtFEzEt5z0HcUYIBkAOZM1fLNE8QDwwK0iiOOo9eZfh79vRDkuzd59IAAN
 G8qkjyiSSWy3ldN+Zhnnwky9UgHi4Zp03+jihbNOoCZOG4q+olATngZWMFtt2VFQsFpz5IH964h
 WFpm4MT/HHyKAgUaQ=
X-Received: by 2002:a05:6000:220e:b0:493:e0db:b507 with SMTP id
 ffacd0b85a97d-499c38baf70mr3230262f8f.7.1794388959248; 
 Wed, 11 Nov 2026 01:22:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4989a2a505asm8203394f8f.13.2026.11.11.01.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:22:38 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 09:22:37 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: c4d3d47750d4359fe2726370f3a69c3558932737
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 09:22:37 +0000
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <541c77904728ef39d385c67285a7b1b16de3d7c4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xR4XV-000000000GE-3tK0
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: keep
 IPv6 name servers in NRPT exclude rules
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7754978859343302178=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7754978859343302178==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/CeJtbnusWw="; charset=UTF-8

--/CeJtbnusWw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail )

Cha=
nge subject: openvpnserv: keep IPv6 name servers in NRPT exclude rules
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(=
1 comment)

Patchset:

PS2: 
> sorry - copy/paste'd the wrong line=2E the i=
ssue was in the line below=2E=2E [=E2=80=A6]
Reworded=2E



-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339b=
c9e972
Gerrit-Change-Number: 2162
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <an=
tonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 11=
 Nov 2026 09:22:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comm=
ent-In-Reply-To: Antonio Quartulli <antonio@mandelbit=2Ecom>
Comment-In-Rep=
ly-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--/CeJtbnusWw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2162?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">sorry - copy/paste&#39;d the wrong line=2E the issue was in the line=
 below=2E=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Reworded=2E</p></li></ul></li></u=
l><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
162?usp=3Demail">change 2162</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2162?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comme=
nt </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2162 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerr=
it-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;=
antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 09:22:37 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Co=
mment-In-Reply-To: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--/CeJtbnusWw=--


--===============7754978859343302178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7754978859343302178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7754978859343302178==--

