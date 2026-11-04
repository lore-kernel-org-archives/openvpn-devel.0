Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92D606A329
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ChUOC0ei;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HWZU8g4Y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=emCsicbb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fK/6FcAe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=k8SqAITY2lpoWUrgE/o9FU7u/K2GXg20gg+SXowuhQI=; b=ChUOC0ei2bEvL1pCAVHAzBdwQt
	snSb2gEOOgAQ0cgU5M8jpk6sCyKidWuH/daWKsZ4v4XeA4d7hUup9sTqO/w3RN/AFUmgfGPlVs0vC
	rv1KQ2b6eM8kMZXKIRMkbfzHkTb2X1+O+ViAVrqJPuBBTfXFlivZX9wtL+CBJZ983Ag8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOY1t-000000006vM-0PkC;
	Wed, 04 Nov 2026 10:15:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOY1Z-000000006uy-1r1k
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:15:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M5RZ937xddoxAQ20BtNx0YRf/WZAjUqMHlryMyWu+Bs=; b=HWZU8g4YRtm/R1e/IWXGE55SDQ
 26gm+IfsoCyUz5+P57WFlF95eAv6THYH3ZeSRVly8+AP9yLnFKmpens6lhbg3DrG/5CGsdLjSjO8J
 lh0aynWwT72rxvTbdHUvLL7fWMTo2vOUpZ80znibN/xXLfHIsLzL+OYZmyuOeMulqgTk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M5RZ937xddoxAQ20BtNx0YRf/WZAjUqMHlryMyWu+Bs=; b=emCsicbb7LMNoJ5xHAM3zvX/a7
 WB/vm85affl3SnoRv4/b9oI1xlaOueGO8JpPsId6mzGKtf/Ug/j98jazsnj86uun92Rd9X0YASPtr
 GOLBf1xn+daVeBnxzLTskkSlqNjleI3ccPZLHD5pX+8eptRLgfVEwmoq0xEvqLlAKNmY=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOY1J-000000005CU-0Q88 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:15:07 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so4858015e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 02:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793787298; x=1794392098; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M5RZ937xddoxAQ20BtNx0YRf/WZAjUqMHlryMyWu+Bs=;
 b=fK/6FcAeK1AhsYwskur2kR2Gw5cvPu0twByOzaylE1DAucznJP82qAB595uO2lur/V
 FG1DUMvlY2zXI0xLtuk/ZMCycCjZC1wD/4NTNwnsBI5rWc28j0eqtxBACVdjrMcAtQJ/
 xP/2317ohqwJHzewmrihuhwznnbaFoiZg/ODOL8d+53SST5CgAG1E3U+PSDMv4AeE3Gn
 WZmJemfXj3DYo3OJu6YQp5xYxg6HQOyCB69Fj+7yss0rMAg0zNis952Fzpadb+jL9aUP
 D/AuDGV0I9ohi5cixPagZSvAc82Vwk5F/opJ2ZncuB75U/NEnZl1UwzYwwmP9oGryhx5
 ahBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793787298; x=1794392098;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=M5RZ937xddoxAQ20BtNx0YRf/WZAjUqMHlryMyWu+Bs=;
 b=ibiGZQHTjR65Y2GVEbtH/Ee2E23qIfEGWEPim5MbgosIori6SfSYculG8TqIo6ni6l
 SHmYqOMQekaKbLEEuTHxhEg+RARjxEb1qo9ng1Gmc875zIxu6TTUkTQmubU64BiDAv1J
 Wrlk0hQGz+F1ylSQTvuFF3mcU5BtVv46NDLUvScul536P/8WpwiLAjJIJ36jOloj6MVi
 zhxNavZPfDOcQMwP0+t/5DXcbPsHIeP4O4EPdjAWlZt0ppFZpQCeyfej7PfwhYTqni20
 mIVx7nlJkWtcv+8bmMyv/ij9cc64AXJ2VxOiq4im+KSLfvmPNOICon+tgnXRR9ivA/yG
 JTpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwV+Tk5H3ZClZmh0qNNrX+qbDpCu1PiGdhPH7e53edeqoQXMPjqRV6V4ItfLg+6vjn7TmAnrLiiZxOYnL8H@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9+M5jOVCw57XYEijrDoZe5Ndc40+Vfr5h/YlJOm18cYw1AQRVi
 vr7/v3WFxNy74yYfri6SnwQL4MTGhKFHUvCFuHxGckeVay8XaYTODtSqMj5HBg35kBLpURuiVBW
 iMETj4uHfaWyMPIUJ9z2wv15N3BmYL3NuGD5qXs1BDJu9mdaEOMQ3em++hgNINC5JyhuT
X-Gm-Gg: AYBFou35RdD2qkCBo059Nw+PFHT7HE37eF3DTGgK0DrZj5NggAvHU9vFR38CiQsk0+p
 nB6yXG2Cjb0E07lFOSvXz6lzqgbhHZZBJKJTiyqsDcmawBefNvB0dH/H6q+pmaK2V1YT3MvX/Ij
 xDIkM66zgktk2JHu1ANHSNRqxCfQEmm0RbNYrnO1Tc+U9JhjQxhSHGnRMFaRjIoaJrbaOKeL9kK
 owB14UbUCS7wJ4KQbYt4Q26lXMumi4W+vwscHzhFvdVLc7CN3lGPqN6t3Pa2+m4OD1JMNzv34ab
 emg9EZEzv8OYLVxZ3cRw5cfrZy94JcVAJSHKLQtwiVir4ij8sIqg0U65G8ehVqI2BCCYaw4syTB
 UNFKwS7r4Aiovfn+xoJW+mvGKrVziMKAaGYSPohj6Hngp1tfV+hJrRIU1jJZlqfyNm6YaPTEWi+
 MswjKqwc8nlRsbGnnw+KwWdqICXo5xdIUXmLQtckJVsalzRkhg4Q56o4erbbW3GdS8fpKF+3LvC
 yIb2dAppYQD73dO6ELDMtHI80XMzHPOpA0wexRNNElaqpWnlGGcjCYsp0TZr12DKgudju5PMdQf
 n/+ADopmgC4Rl6G+aeDs0cWFK3y/lo06u0bJbsBfVHsDEFcjWlF7fRIHq8sHpYx8LTuiLERN+vT
 mXqfv6h+PPNYnXFLmXWJuOnKC3V2v5lt4JZNLqpZ3dOcU5+0YPfs+38JQxeK2IJWM4TPtyrZEDY
 6qaPy6JySdoDtSeo30fhXfyPoFhCErImVjWHM=
X-Received: by 2002:a05:600c:848a:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4ac17b2ce84mr392241615e9.6.1793787298318; 
 Wed, 04 Nov 2026 02:14:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43cff3b14sm41641195e9.10.2026.11.04.02.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:14:57 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 10:14:55 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e
X-Gerrit-Change-Number: 2060
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2060?usp=email>
X-Gerrit-Commit: ed4acc88e80d08696902ef2b387f2f44497b1fb7
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 10:14:55 +0000
In-Reply-To: <gerrit.1793194671000.I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e@gerrit.openvpn.net>
References: <gerrit.1793194671000.I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkk3NWJhNzdmY2JiMTE3OTBjN2NjODZjYzQzNmZjNzVmZjk5YmQxYzllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d9b119eb593386cf39adfb1d08b58774b25cae56-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOY1J-000000005CU-0Q88
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE:
 centralize virtual address changes in update_vaddr
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1798769354786484407=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1798769354786484407==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8cPtH4EpPII="; charset=UTF-8

--8cPtH4EpPII=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

R=C4=83=
zvan Cojocaru has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?usp=3Demail )

Change subject: PU=
SH_UPDATE: centralize virtual address changes in update_vaddr
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
-1

(4 comments)

File src/openvpn/multi=2Ec:

https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2060/comment/1ff420e0_0b1688b5?usp=3Demail :
PS1, Line 4451:=
  * @param new_ipv6  The new IPv6 address, NULL for -ifconfig-ipv6 or the c=
urrent IPv6 if no change
These might read better as "NULL to remove, curren=
t address to keep"=2E


File src/openvpn/push_util=2Ec:

https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2060/comment/bf4e564c_305dd1fb?usp=3Demail :
PS1, =
Line 152:     /* Set canary values to detect -ifconfig and -ifconfig-ipv6 o=
ptions in
Stale comment referencing canaries?


https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2060/comment/22429f94_8244d057?usp=3Demail :
PS1, Line 161:=
     struct in_addr addr4 =3D { =2Es_addr =3D htonl(mi->context=2Ec2=2Epush=
_ifconfig_local) };
Computed even when `!push_ifconfig_defined`=2E Maybe mo=
ve inside the `if()` below?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
60/comment/ab13739c_b8bebbba?usp=3Demail :
PS1, Line 221:         return !e=
vent_timeout_defined(&c->c2=2Escheduled_exit);
Wouldn't `scheduled_exit` be=
 true in several ways (e=2Eg=2E if there's simply a pending kill)?

Would j=
ust having `update_vaddr()` return `bool` (`false` on restart paths) be pos=
sible, to simplify this logic?



-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2060?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e
Gerrit-Change-Numbe=
r: 2060
Gerrit-PatchSet: 1
Gerrit-Owner: Marco Baffo <marco@mandelbit=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Marco Baffo <marc=
o@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 10:14:55 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: Yes

--8cPtH4EpPII=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>R=C4=83zvan Cojo=
caru has posted comments on this change by Marco Baffo=2E</p><p>Patch set 1=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?usp=3Demail">View Chang=
e</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2060/comment/1ff420e0_0b1688b5?usp=3Demail">Patch Set #1=
, Line 4451:</a> <code style=3D"font-family:monospace,monospace"> * @param =
new_ipv6  The new IPv6 address, NULL for -ifconfig-ipv6 or the current IPv6=
 if no change</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">These might read better as &quot;NULL to remove, c=
urrent address to keep&quot;=2E</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/push_util=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2060/comment/bf4e564c_305dd1fb?usp=3Demail">Patch Set #1, Line 152:</a>=
 <code style=3D"font-family:monospace,monospace">    /* Set canary values t=
o detect -ifconfig and -ifconfig-ipv6 options in</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Stale comment r=
eferencing canaries?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2060/comment/22429f94_8244d057?usp=3Demail">Patch Set #1, Line =
161:</a> <code style=3D"font-family:monospace,monospace">    struct in_addr=
 addr4 =3D { =2Es_addr =3D htonl(mi-&gt;context=2Ec2=2Epush_ifconfig_local)=
 };</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Computed even when `!push_ifconfig_defined`=2E Maybe move in=
side the `if()` below?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2060/comment/ab13739c_b8bebbba?usp=3Demail">Patch Set #1, Lin=
e 221:</a> <code style=3D"font-family:monospace,monospace">        return !=
event_timeout_defined(&amp;c-&gt;c2=2Escheduled_exit);</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Wouldn&=
#39;t `scheduled_exit` be true in several ways (e=2Eg=2E if there&#39;s sim=
ply a pending kill)?</p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Would just having `update_vaddr()` return `bool` (=
`false` on restart paths) be possible, to simplify this logic?</p></li></ul=
></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2060?usp=3Demail">change 2060</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2060?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I75ba77fcbb11790c7cc86cc436fc75ff99bd1=
c9e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2060 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Marco Baffo &lt;ma=
rco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 10:14:55 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--8cPtH4EpPII=--


--===============1798769354786484407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1798769354786484407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1798769354786484407==--

