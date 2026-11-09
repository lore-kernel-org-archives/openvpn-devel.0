Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AEC606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ETpdW+Cf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IMP8DHn9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ATiqZv5p;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DzXP13FD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4xl/oPrusErDvDwTAlv1RLdpNR/74mnl6eFeCUGMHVM=; b=ETpdW+CfvRlw13lx5MHi7onIW0
	oxsxvpCZOtypoVGcput1Q/7dJGKs6Db2NpJAHMA71NCRA6QR4LHGINCH4EfOVmDdhwwioqDcDlAZV
	WQfoRpqlx7acf9TQ6vlcxlrjupAYAZ6spwjosEtCojPsccVMNyYPyGBUR7wAKd5MXRGc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQKj1-0000000072u-2w2s;
	Mon, 09 Nov 2026 08:27:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQKj0-0000000072o-19fv
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 08:27:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VmOfllnrS83Apa3N/jS4Cuee0zB2JuugFG6E4KgWFTQ=; b=IMP8DHn9Cqgco7lfrYuGXWvoMR
 3kaZYcU8sxzBy2S6Nc4YjxNzKTqEE15YB3Oi/iUVRsrE+NV+yMdPz1i+zOyO33vYGJpDKNRbSms2H
 8j67AZAqq7HJw5SunPn1VzJ2OQ8/dhwlnneb6qF5BQWr2D2CREoiJ0DbqJdRf3W/5NWM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VmOfllnrS83Apa3N/jS4Cuee0zB2JuugFG6E4KgWFTQ=; b=ATiqZv5pkKTP0qHKmPJRqLAjlx
 4BDH88jUbWmq7G4FUGBo9ywxfyIzKV+p0Frp/W08s1k/z3Lrl6GG5MsLzicbeztmaT/CX7t9BugBk
 G/fOqYxp5/g84Fv1L5H+ztSlHBIRfzEAUoC1j7VKKiMQT3/xqRk0D2ybeT5IuUHMxDQ4=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQKiy-000000007eT-0HzU for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 08:27:34 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-490a0e72588so274185f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 00:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794212845; x=1794817645; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VmOfllnrS83Apa3N/jS4Cuee0zB2JuugFG6E4KgWFTQ=;
 b=DzXP13FDDhrKl6qsiSoMw8JPlvMs2oV6bOkw7pSmhcIx6h9rXcB4d74gY/rMo9x5Lu
 nelkl4zePSTCFVTSrfAjkeEEGIVkPjfAi8oBq7LjzFWWqjeQZ9PNkGQ7/XzzFa47r4OS
 2ObeY9dup2MvxsH3/OPMl1KYkK72WXsd4Prp67XTTCa5F+rEhIELptAPp0GU6gaGxu6Y
 Z1OyQRr/QIbf5rj5Oi832OiB3z2lthkw19xz/hESPGWPo8Wq97mW3XTNkK2P3Twy/g+O
 Fm/kFTuzwF4txqbVnBOLfD5KOM7QRPq7kDMBSQc7oGjoBpi0p7gLd6oEag5+ceWLVssw
 BsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794212845; x=1794817645;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VmOfllnrS83Apa3N/jS4Cuee0zB2JuugFG6E4KgWFTQ=;
 b=a9o4Ji7zo4JSWpZi6w9FX05Ikd/1dwn4IL+Bx5b3BeHhCXyrvTj8SE4wOp6z50TUtJ
 eX9Y7wTv1TNHdqfWKNywSmXVqnX1mzuNpg1RNMicqbQDDcLEhaD6aOWgJZaXQ+q8nVsU
 FM9ABZrx2++ZjYd9pZ2cDo37F4BNET5qzyP8ModsdvZjl1/FS7JYlH8xiIfkMPz+bMNa
 S98BDS3IDy0jJpwzyMD3F1fl3UpDubE2o4EYeXnKaZMiubsDKlYOdtsVJXFa11q5+4B7
 9o2LGN+PBojcUDyViAqdIshLiQxXINeBP76dCN9OXAx0y3czQqqesVwT+voBEdvPTrg5
 W15A==
X-Forwarded-Encrypted: i=1;
 AL+hErEVeb/jaCM6OLA2DPKYbbfLR2/aqOdoa3OKVKdG6A2/DpHuXo0Ep9SyHO+VTyQXz/F45hJ9WeRdjJ+soVYs@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8ORWwPukUTN3bGI/lFoUbgf+aLMPe0IMQl3V7hmlHk8aT52MYX
 9NMnJeHJOOl6nHqvYAJoU2RD4J/Q2uLPn9MVBe0hjkkJtydNdcWITV0TKAQsDlJTV5TREYZSPKp
 K855jqqCZjI9/+tW4zJAlfz7z0rvUs7zutN8Gos9l90YMYgZe/pif+QyIQLZkLezO8xFe
X-Gm-Gg: AYBFou04kHpLlRjs0bgLyxcSVuDukgZZJ7txSVKh+eqhW+KUqK+FgHjGoZprlM/39Hp
 nEgJp+8Nva2AWUSMNXv5BKPQ2rdyFwkGkADQad5iwb4lDfSSu29eHG9soCKB1XxpheAJd123Ynj
 i2OAg2U74Y9RBkrGEzeq/HzfimjbwIQ3W8yJklnC6YVfduMZoRYd9LWLZVMCVSkeR1U9b2ayZla
 oF7W1dZgJj3zZxo7DTfOvNd+BI8rOGfvbYV6FIIvipGlkelPq6QNSOXHd552kuKGl//NDmsKtx0
 ZpXC+VVS3JEH/eQewaBUwA4ndS8cNJMsxrhiPt3fUdac2v/1+5FaOzE/+IqByrxOTwWXI+wVwnK
 e5rccBezhjW+ULNGDpbttWJL2VGXNF3Dqg/xFRbCDlAeECa2Q+ZYMCoh2b3e9AZZ0l4TodP3Tpv
 bznKSm1pXkbzZ035aIhOmuq1Mzkc4bsB+hi3UxoEJfgov4aKObHq6Jn2f5xYaI7THCPvYxzz/01
 KKy55wmyIQd/NA+se5iblJ+tmAt4LkXDVF1jhANOeCEjBav/yTHDmWgnBXKGbDA0QYMaaI2bEf0
 Vlk+Qv+gncJZtp8XVBIFJwl/gLQlTWg+QPEQQq60OOU+ejNNbDUCv/vOL96ZLNVVjMCOgqsKTNO
 Q5NA9q3qbuJfw0DpoBcL3Pn78lh78yfwQKE9FoxvInw/9QKasND4BK2Rgno94sRsxqYXOe2cHQl
 v/45gonTftX5WgIg==
X-Received: by 2002:a05:6000:40dd:b0:48c:5304:5e50 with SMTP id
 ffacd0b85a97d-4957c4f9d50mr6452214f8f.0.1794212845412; 
 Mon, 09 Nov 2026 00:27:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597748acbsm8418751f8f.44.2026.11.09.00.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:27:25 -0800 (PST)
X-Google-Original-From: "Yuriy Darnobyt (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 08:27:23 +0000
To: opidopiopi@gmail.com
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
X-Gerrit-Change-Number: 2148
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2148?usp=email>
X-Gerrit-Commit: fb3162d2889759568a5887f540be5cec0786a978
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 08:27:23 +0000
In-Reply-To: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
References: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDU5NDM3MDAwLkkwOWU1NTA4NWNkZTZkYmMwMDQwZTExMWE0MjEyODUyN2Q1OTgzMmI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <35feadb41b56b00a6f3fbd457b5dfa6f8c50c740-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQKiy-000000007eT-0HzU
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement multiline
 responses for pkcs11-id commands
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Yuriy Darnobyt \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: yura.uddr@gmail.com, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 opidopiopi@gmail.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, gert@greenie.muc.de
Cc: "Yuriy Darnobyt \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3736073272792281808=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3736073272792281808==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mL6GZhcIbsU="; charset=UTF-8

--mL6GZhcIbsU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, opid=
opiopi@gmail=2Ecom=2E

Yuriy Darnobyt has posted comments on this change by=
 opidopiopi@gmail=2Ecom=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/214=
8?usp=3Demail )

Change subject: Implement multiline responses for pkcs11-i=
d commands
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 4:

(1 comment)

Patchset:

PS2: 
> Tried with a fresh clone of g=
errit and the tree error is gone, but: [=E2=80=A6]
@selva=2Enair@gmail=2Eco=
m I did some permission changes when migrating to GitHub OAuth=2E
And indee=
d I didn't add you into one of groups=2E Added now=2E Please try again=2E

=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09e55085cde6dbc00=
40e111a42128527d59832b8
Gerrit-Change-Number: 2148
Gerrit-PatchSet: 4
Gerri=
t-Owner: opidopiopi@gmail=2Ecom
Gerrit-Reviewer: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerr=
it-CC: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: Gert Doering =
<gert@greenie=2Emuc=2Ede>
Gerrit-CC: Yuriy Darnobyt <yura=2Euddr@gmail=2Eco=
m>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: opidopiopi@gmail=2Ecom
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Mon, 09 Nov 2026 08:27:23 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Selva Nair <selva=2Ena=
ir@gmail=2Ecom>
Comment-In-Reply-To: Gert Doering <gert@greenie=2Emuc=2Ede>=


--mL6GZhcIbsU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, opidopiopi@gmail=2Ec=
om=2E </p>
<p>Yuriy Darnobyt has posted comments on this change by opidopio=
pi@gmail=2Ecom=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2148?usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2148?tab=3Dcomments&amp;usp=3Demail">Patch S=
et #2:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">Tried with a fresh clone of gerrit and the tree =
error is gone, but: [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">@selva=2Enair@gmail=2Eco=
m I did some permission changes when migrating to GitHub OAuth=2E<br>And in=
deed I didn&#39;t add you into one of groups=2E Added now=2E Please try aga=
in=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2148?usp=3Demail">change 2148</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I09e55085cde6dbc0040e1=
11a42128527d59832b8 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2148 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div =
style=3D"display:none"> Gerrit-Owner: opidopiopi@gmail=2Ecom </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Selva Nair=
 &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: Yuriy Darnobyt &lt;yura=2Eud=
dr@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: opidopiopi@gmail=2Ecom </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Mon, 09 Nov 2026 08:27:23 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerr=
it-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: =
Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Comment-In-Reply-To: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>

</body></html>
--mL6GZhcIbsU=--


--===============3736073272792281808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3736073272792281808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3736073272792281808==--

