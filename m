Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6CA606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AWAtZmHB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kbDtZIHs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Uy6kXS/s;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SdFn5j3V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mMoZzvxfFroqvHwGRgQ3Zk55UhdlG2zATSndRYFU5UY=; b=AWAtZmHB56cN2q0ZEFVwpXxYeY
	TtULmfmDTtmYwKcRXaI6q0tRlDa/btJm1v6Ui2tOqa8ImGLn1kzw9Faa1SqJCTJFpHQApgBkRa5ny
	TG5BXAuBRTy2WSbk7oU+ug2VMQuWbNLdFmvFcM+WBpEBL0gpLfm79hziRSA45DVgGuCg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLeSV-000000007Xx-3zJW;
	Tue, 27 Oct 2026 10:31:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLeSU-000000007Xr-1yTM
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:31:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DTe/TBdSi3aRdNtORWcDCM7X+TJfLI9Uk7dO5LXPRf0=; b=kbDtZIHsGK81nkhXD4PVc6fkTZ
 ldbXP1iVrem5XU1Ekx0yB8/+Y3gxExhoB4BCR2Qx79QogOOhnuU/jM58U3GCPNBBB9Y/1x69fIIh/
 Fi86hP5lZOrQvurNGXX5YLPsX30K+X27Xz3866y2Aws6E8HFRTSAdbHfCymYFPFjPv+w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DTe/TBdSi3aRdNtORWcDCM7X+TJfLI9Uk7dO5LXPRf0=; b=Uy6kXS/sktY9VikQ2Q2ArfPoEH
 OlOFbwnY2jOmCu50N1IZc+eeSQ2sc5JKnJTac22H89yo5tKH9X3MXmAxz3YO9ejTT4CYZCmYiAP5U
 FQ0l+VHT5SqidU9iXsZCInuegmC94o/QEw25K1zqlP9xmc+TtQN2NBKW66hzwznrS5H4=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLeST-000000002Py-09Ib for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:31:10 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso30917565e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 03:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793097062; x=1793701862; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DTe/TBdSi3aRdNtORWcDCM7X+TJfLI9Uk7dO5LXPRf0=;
 b=SdFn5j3V5Ri62XlnZp6FpIHwosyTrHK5I3O+owjIaPw0VSTfAq98TYztjhwPsFBdP7
 hyqvfr8lnOhCUFagyE/kb+K3reVfydUjxhjl/JDkUJkSHsY/Qd8aq8mYZgIFCxq8erDI
 eDfOCO6uZvMXTuOQDbXheBjNvYPW+iH+/BxCJm6UMkDDhe/bbGP/6yLHfqEtMb+CbFXw
 PWwkFNfuo1Yt/Qncda38zk8ecjACRVLW+b37nUtqYpE/mux8ug4CDpQqC32PJE86Q8T+
 7V75b6Gz2R11xCMy/j7tivZ6gnVOJfW6X8d/I9tuh8MkH2qbBy0Hz4j2iF5QWcKtmTIM
 v4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793097062; x=1793701862;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DTe/TBdSi3aRdNtORWcDCM7X+TJfLI9Uk7dO5LXPRf0=;
 b=A3T4GKq+FNBIqjRTNNgKmWwvhLofFOz+qpDULIOOtfO+BPaOSPMVvrL5zShKCmxHrZ
 P6Pc8x1JWnOxtnPDU7a5lwiOT89DTVcFPna0WcQCk6zdOVk9rBSM5k/9zQCIpeTFFOh/
 fIaiBurzZ3a9k/1bNCO6vut0Y3Y4XkfJpfXTAbLvhZ+KMM4E8jWUXlXQBsqTvvk9a+gt
 wxBa1ld3iFPfVIefHNkQXSJ+6hL1fqSbxu3puQb8fafngWah0asskvK7ffVKIqNnz2AF
 0ROQhTvpxETuKso2Q0xSS7alU67z04amg0UMDDCjMDJPcg3JhwzEKRzyDKyH8wnRWbQy
 ShKg==
X-Forwarded-Encrypted: i=1;
 AKwUvByczwVB4mR4j7vzd8VNxH78rVr2ao0Me7rb6wrJVHsvxdbCVJX+fTtrqAHvYpb3Vo4UH70ZBmKNlO1Ji9EK@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIh4LrhzBTlfGWoo9CO2xggggV468TIXqyK7fgfmL4Jy3MDaiB2
 ob7oyc2MN/klU9Lh9vuQOmRkodiDMEliakY3P57cEzD8yXOmTpo0nbgWVjOgqtYf6HKJGjzkXxv
 /+sDgA2S8dHbcAPWW2N7T5HyC9kAmGit41/OSaoQBoJcrv0XFKt90WIKfbxZVZNnbm0Y0
X-Gm-Gg: AYBFou1HeEoWVCiB2fI1OGIclt+Hq750h49zyyO+EisY1LMe5Fv3JJxm41wkjeCfXJE
 10uPQMIGwAxOp4Q154QbuqFadj2kyUGo7cUFx0+qGJG6DMKik7L2WNh0yelM3RYN2ui11ecUVPl
 X+wxaHwDZSTKUKEU86T0Hd7lyxt4PzgSbeT9fTxuv/Z/4ezFARizvSVqN2ex0Py9BnYZoXNHYxK
 egogKsA2zrBlDbSz5QNTiUEvbWNfzGmwxgOZrq1XUqrugcv0XXh6LVBRGOaQ+o3IIVTwP5IYqg/
 sCXx+7LcjMiysX6SRfj6eFSxC2zyZhEFb7jObaScA607gDQWM8ak4Y7emKbVOin9Yw9SVD16XM/
 HoYEUwtqR8u/0qDRbbj8HbSav+/eyU05o5kx986IfWYJsiQITKZrBzK2Nh+i9ztcb5JbSo+rdO/
 rpU8ut4tBC1dUC0PfiyvRBB/gltmlG87z9JwvLUnuyEPS7dk8imquKFA6seiAknR1aqA5ufKOLd
 eD2anjUirll4QogKHF2nO8ocJEfgrxkAKj4b6lZUHXh6vkuBZo6/87qNMEOYhMXWGyDQr1SZd2j
 cmNjPvZV7yEU7SGve7p1bKYAgJ4p7NSfFwEfhjXjGf37xwzRIIrFLq+WwZ2/KQWBCcJ+zxzm/4A
 vhLq4NmT/SegVBAMYThg/ftyZRBkO56WxtPksQx8XSg4=
X-Received: by 2002:a05:600c:34c9:b0:4a2:994:575c with SMTP id
 5b1f17b1804b1-4a35acb994bmr179995745e9.34.1793097061318; 
 Tue, 27 Oct 2026 03:31:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb8d5sm23018631f8f.28.2026.10.27.03.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 03:31:00 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 10:30:59 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I603585c6bb4e407d0df62f4233ff2c135aa00db0
X-Gerrit-Change-Number: 2041
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2041?usp=email>
X-Gerrit-Commit: 2e48699e11ea6707ff614a4e1875347ade768c24
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 10:30:59 +0000
In-Reply-To: <gerrit.1793094393000.I603585c6bb4e407d0df62f4233ff2c135aa00db0@gerrit.openvpn.net>
References: <gerrit.1793094393000.I603585c6bb4e407d0df62f4233ff2c135aa00db0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk2MDM1ODVjNmJiNGU0MDdkMGRmNjJmNDIzM2ZmMmMxMzVhYTAwZGIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <472749e66bb3e0abe9e8aafa8c1ed5f402e23a06-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLeST-000000002Py-09Ib
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mtcp: make
 set_global_rw_flags TCP only again
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2204423023775471045=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2204423023775471045==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SMN92mEczMw="; charset=UTF-8

--SMN92mEczMw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2041?usp=3Demail )

=
Change subject: mtcp: make set_global_rw_flags TCP only again
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2041?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I603585c6bb4e40=
7d0df62f4233ff2c135aa00db0
Gerrit-Change-Number: 2041
Gerrit-PatchSet: 1
Ge=
rrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>=

Gerrit-Comment-Date: Tue, 27 Oct 2026 10:30:59 +0000
Gerrit-HasComments: N=
o
Gerrit-Has-Labels: Yes

--SMN92mEczMw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2041?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2041?usp=3Demail">change 2041</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2041?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I603585c6bb4e407d0df62f4233ff2c135aa00db0 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2041 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 27 Oct 2026 10:3=
0:59 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--SMN92mEczMw=--


--===============2204423023775471045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2204423023775471045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2204423023775471045==--

