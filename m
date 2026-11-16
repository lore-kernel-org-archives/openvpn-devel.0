Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289CB606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M1UwLYuL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lI/zQibJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Vhn58E7O;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AbDhxr75
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RzSb/mg9yiVDYOqEs2kkOfwm07WQgDpiCoO9XQwVUGA=; b=M1UwLYuLUYF+zbksOwM5SOB9rf
	jsSjqLyhS5G0vjxhdy4VuoZrrse19M9lle0TicM+WAW4w1VjrbbIN5D6aF+FzEf4WX0KEKEhr+NwV
	heN6th6Rqw4E7zu0G2yJqCvOAtrquDdKdNbNpl9y2knCVAULR1crU91rF4JKEWFlvAzo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xStQ3-000000007GL-0nga;
	Mon, 16 Nov 2026 09:54:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xStQ1-000000007G8-3qQc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:54:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aw0J555gRsMYP//5Mcku1msS+7YkIQdVXP/zBifKtEE=; b=lI/zQibJe25UW0jnCDZs7efzFD
 HC2P8m242dP/z8BcKeDtCs/M67wgW4f1/In7CF/ZFZxKOqYPrrXUoFW6OlSjAzkdK6djmnhfCPZL3
 Q35bq303Bu1gJ8oHWpUzXaq8m3KDtq8tl8cLD+EP0fJlqf0uC/E0gke8i+6vnlz4YhTQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aw0J555gRsMYP//5Mcku1msS+7YkIQdVXP/zBifKtEE=; b=Vhn58E7OixhffSUHfKorrqZB8q
 699NqDTTrb8i2DOR8CIzYRpkG8s9hySarzfP7gKhOha/0vgA4c3k8XPbz7z4Tc4u06ftPV4KjSLC0
 ePvlatlrWVD22zjmcoHIA8kG9NYEmWSoaHWRFEfg08824+Bu2D+SZlMbAP3SC/1R1vxs=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xStQ0-0000000007t-1XLA for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:54:32 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so36046035e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 01:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794822866; x=1795427666; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aw0J555gRsMYP//5Mcku1msS+7YkIQdVXP/zBifKtEE=;
 b=AbDhxr75l9FbSMnoaHIPC6isBekV6nFpMl7qMXMmBxYwCEQaj8EoKQBsaqhkn5uOtr
 Trk/EQUE5lJHBoLO4DFn6hDf80EytB1xC9fH5sxHGDn0p3glHYIagbMzNWPeRbFU0Lsq
 1GkpP5U2HBqnaNorZMtl3GhKo6hnNGtGTk2rLtSuwCELyN7cYGQx8PNL9mzceVDp38kh
 ljt/iEeG5yG8NJy2/dNfnnTb92Jp5+bsXRMsGdz3+SCxm0CiLWMnfmqblxVxNLQaLCjH
 Pd1CU19VnsgFzLS5wygc9MSEv9ceZX+PbMzItKnFFgstOJZq1TfFfb1ohHi4Vb2sbGXu
 fPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794822866; x=1795427666;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aw0J555gRsMYP//5Mcku1msS+7YkIQdVXP/zBifKtEE=;
 b=QhIJUGo7DkKt/GK8WEs/i7pri+9BmpucFN0mJe3sdXiUyeVen0fYXiyoEfWND9L02R
 rZHELlgbIAq+YzaMaiBwadMB61UWLIP/eHyIM6aeqg3RAkV50UyBlEg9aU+6JL0vJ6zH
 HwWuXBtvO/fmx0StyJWTykpJpfymyt2Q9lyU1OsPRmbtiygr3kLoV/W20X5jNP3nSftR
 nB7r02QTbGy5ol+TQf9gkwl6bQvZGrWCyxBW0L0C/jiGlbcMPKl5DzX9UKCkgBMxnt/z
 QoENjuTLq+iBmBMNCgsrxFzuSDRSW0Xz2JFvE2J73C8Puu24h0wu0O7K7Z+P1n2+QqsI
 iMsA==
X-Forwarded-Encrypted: i=1;
 AL+hErFUyN4J4awu9YQqv6Xygs3VcQdKy8n+9bYF/TLuA5qBiFwQ0TVdDicL2Xt/qqRAWhqAPQEplqzf8j6DsDQw@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9OBvgPGuQtG1fkWe9M99I5ZI07rJXZfbwrjLO1NRMtEQe17gT9
 CxE+UmIkyYGXQCs+HJmrZulUvxGblJcWQRVOscuriKFzFqnBapNyUYjXURpDFzpG9fYRqGftmbq
 FYsqga3F0B/tQlophb9umARffEXXujLv6hvYsU3v5gFhHcXuirZTMkgfYkEs0auRdjmnK
X-Gm-Gg: AYBFou2HB74XIg/n16/WcDZR/NrajANYhO19xBpf1x0FbBO8BMcF49HeVIreI19FHx3
 cGViGvJa//5PGXvsfLIgQOPnDEfPskDtpUbfNS+vp7nFA6v7/WB8GDUcFRvH9rlAutnG5heqZqZ
 XeNii0bDoMF9AbClrKDojQayj4Ub7fO/dYMifBnKGxz2S55u+TMVGT0I2Z87+E8pbdKXx8DOhGz
 eIQ/53k6tmDCZ/WI4/8HWMZqTVNdfZcXjyZTiXe0Xs/t1OhZKT7168zuF+1sfsZAbocLZorOLko
 rBv1tPqE9QdERAbbhiQOi1Jd/FUQvmNKIjIRJU8jA0HHkXXdjKCm/8KOKAoVZ2mTmmDYGEIj7au
 4gtJRKUOQgm29703GTihdAFiAzX+L09qM/r0gKAPhNu0RGrp64r1lJHULzAOUu0iI73SOYY2kAi
 yoG8zJWsYHsE3wzDRsp3Czbpbn1PxTtkK+TwK/mfjxsrpfmWrvS5zb1B4VJ1rQRyDfADI4Lkw15
 dsSts8GtoGYwDp+RiZAIzK7ECVhq9kIjuvoSek57Zejz+voilIBKw/7Bv4uWuC+VWtBWE3aoFxZ
 GwrjETkhqCR/EUPXSEopxh8zfN0BEPVxM1qXuXbzao1SGFS3RcoiFWSQalNcBHU9g68HX1fJfhL
 I7x0WEAoff7YnY/crjN/Pel40cEdnJX++/lipOmwOi5B4AMuKDFCM4y/YgDjZDpCdeUnR5J/Tp9
 xm8aZB9sWRsIcH0nVlZoZVJMXPivgkSyOpzYfN
X-Received: by 2002:a05:600d:2:b0:4b8:4af2:88b3 with SMTP id
 5b1f17b1804b1-4bb55a67cb1mr156768705e9.22.1794822865588; 
 Mon, 16 Nov 2026 01:54:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c605e4a2asm20730604f8f.39.2026.11.16.01.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:54:25 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 09:54:23 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icb79564ae4e0df1dcdd4a3734bd45f9513f56111
X-Gerrit-Change-Number: 2186
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2186?usp=email>
X-Gerrit-Commit: ee6afd0080a5249a14d02241103462a1feee2323
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 09:54:23 +0000
In-Reply-To: <gerrit.1794757486000.Icb79564ae4e0df1dcdd4a3734bd45f9513f56111@gerrit.openvpn.net>
References: <gerrit.1794757486000.Icb79564ae4e0df1dcdd4a3734bd45f9513f56111@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NzU3NDg2MDAwLkljYjc5NTY0YWU0ZTBkZjFkY2RkNGEzNzM0YmQ0NWY5NTEzZjU2MTExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d6dba980283a3d00050d2a381fbdcd15d77e3b0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xStQ0-0000000007t-1XLA
Subject: [Openvpn-devel] [M] Change in openvpn[master]: contrib,
 sample: drop SysV-era init scripts
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0859140625294521225=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0859140625294521225==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l9xzMqG8YHY="; charset=UTF-8

--l9xzMqG8YHY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2186?usp=3Demail )

Change=
 subject: contrib, sample: drop SysV-era init scripts
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2186?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icb79564ae4e0df1dcdd4a37=
34bd45f9513f56111
Gerrit-Change-Number: 2186
Gerrit-PatchSet: 1
Gerrit-Owne=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: M=
on, 16 Nov 2026 09:54:23 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Ye=
s

--l9xzMqG8YHY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2186?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2186?usp=
=3Demail">change 2186</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2186?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Icb79564ae4e0df1dcdd4a3734bd45f9513f56111 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2186 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Mon, 16 Nov 2026 09:54:23 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--l9xzMqG8YHY=--


--===============0859140625294521225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0859140625294521225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0859140625294521225==--

