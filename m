Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2C7606A32C
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hY8pr5Oe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RUyMjms1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CKanxf/E;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CFBpRj0U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9W7S6twm0gxiVYalTs0I6XSUNXEnH3KHQ2ab7g4lUas=; b=hY8pr5OePHCvEpZX0NE+BmmzAZ
	d+aKr1PgsTfBa8m0k6zh9H4Kjc+HaW+006mEzKn5giNmZnQBn3c30WFOtc4cX13UVixB6q2Uox8tn
	/5SBNYejEB7rUtT1rqEr+9+8L61mkCxjIxalWuxapLldNHmJb7B6DPFEd3xyGlzUsmZk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOBhs-000000006yh-0ewa;
	Tue, 03 Nov 2026 10:25:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOBhq-000000006yZ-3v0I
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:25:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G59w1/IbGo4VSwTRkjrhdytZIHUa1QlWKkKdtc8Hv88=; b=RUyMjms1Q1G0Q66qhQL82XpvVk
 ZEKXtPoo0r5FoFto25FB6t+wAP/zxus30mn5GidiiM6gHQ0sQ3dnpcBrLJsOkYx+cq+MojzUWvGKG
 HsdHDpfsrtgtHMSvkrwntKW5Zzbz3F9IipNlAdspWtlEIxB6ff1SfAKkLrIeHVOh2t0k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G59w1/IbGo4VSwTRkjrhdytZIHUa1QlWKkKdtc8Hv88=; b=CKanxf/EB0Jm+XNrlyFq7fZpaL
 QJ9dCckVxT1zwKlkBXCBVnTcUrQB/TpWLzXYWbIg7WppmDLBOI/u+TJ8SL8bfzJQCGfIcWrQK9qlq
 a0J4qbSOxWYJwyV5ILcHk5svaFKhvMlUNBGnXEGB4IVc+LCUyC5lMRQGHm0IUrPdg9b8=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOBhq-000000007v7-1UZE for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:25:30 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso2040270f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 02:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793701524; x=1794306324; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G59w1/IbGo4VSwTRkjrhdytZIHUa1QlWKkKdtc8Hv88=;
 b=CFBpRj0UxDrii1ATkD6qg2v0fLywsJX6+eSG9owiWLmCz5sxNzNW+LCirB4Plb26V7
 Ta/eM6xdVPigcwElVSh7LVia0our0P1UT/+Ln2fmiApv/wki4aSdeZ9RfHiB5+AMy7RZ
 Cu57IXg1Mj8GrmttNAJ1RGX51UZxXdnkI2N/U570oCbrB0Qz5nvBuHdP6XeYPlBj55AQ
 1+nObyO3HXxqOpozRaloz0uT6C783Qz4u8LkQN5XjhtW7b+Yt9Hk5uF1SeXfqvBmGnht
 xSOkzs/1tupWP3tk6N9WqO5aKBiQ1hQRhcOOBVzEb07L6oiIHZSDh8shITyeAVg1hXv4
 63Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793701524; x=1794306324;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=G59w1/IbGo4VSwTRkjrhdytZIHUa1QlWKkKdtc8Hv88=;
 b=ovFBjoJUnebk+jsPACbeDdCXa4x5Zg0Ax88ErdMoED9IrNrTyN1mVRD144wTdd5F5A
 vEiw/GASVbfi/KIOskqtoIHjLHYAXs5nkdM/PzN+xrqwbvShDRjZBVNVPxpy6JdS0zxj
 0UUxV4WIOlyHLTXPHzs9H4mtjcUWqr2ZGDDr1grbcxeLPwroWEymLePDuAXa2gxKJwPG
 evZboPRkAOC4H/t7ofirww+lfiFyRUf8zvVadBBDw8SziqendS6UV5Y0a0aku1OfaDHk
 c/+RuwCPDJm+j+IKqu7YGHeAGNmPKFfRb+e/2OQ3kdIrbE7FndvzQj9DxLxXM3+dS/ve
 2V1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOkrdCV8ojfn+mocDaByz6VGUt3smxghxfEYpbkm05T2k6G4XTJ1zv6NkJhwEBYdLRamWZq7xoo6vfik5L@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+zagt6VUKd4qV0y5Ji9S5HPqTnPi1eN6uX29MgeJFWFyRp1cFC
 9ZGKGX+c5HKgOBqPojBoI8ZD4HgW51F9W7iskdzSw+Q0nFgZgVvmQy40Wqon0DAL07ktJRmpSXd
 A2Prpp0cyFaIh/AX4J5sKjPcbzk3xPbKGnzTzVedRN8cD23q5X47cTlINZZsKieuWVwTToUE25Z
 eqZZ0LEg==
X-Gm-Gg: AYBFou14cId1Sn13ZB9ef9mXXLBldaBjAdUPy4NVwnfwHT5DzUmTmgc85jQ2GbICqCX
 UUWmDNtVFS2R5O/80zAgUr10gxtE0pUtJ8na2LZdzEhPsl69+zgWT6VHgO7WxpmKHyXjBJPu8vx
 eOpcCiYYy5DIbyzgcP3dSB8T7ZNavHmzxLn9dl4j4gARagNCF8Evr8XGjnOVaCW1PRdf42ab3EK
 Agh6JpmJXWDOGHs2S9WfhmZ+oykBQLBtvFkYQMdJ3eyb8Z1dgze7fUHKclbsg/v4pMzGJFCOkO8
 qLs5WeM+E5iZGtXf2OoZ4tOB+q2BrW5nPTXESEWU4XKK0DLJCrK8rW7v0Z9IZ/Cyp8mjYtbaV5W
 AHgKJ/E5noMYCTcL6l2ckhO4oUqEeYnLjBU/Qnkv0uQnNtYVuz4XXiwqvDemoGlCeTU6GxE7jKo
 lHv3dgVAKG2G/hY6UPCPioJ76diYsM4DujAp+p3MwVVHySoFSY7uu5gieGO1jqPIsTG8cgM3eZN
 L3KYrA/OE6CefTjte5+gFlG4zbikQlE4qTkh5IsBYe1sOl2zzbNvszK2cJ83PwTYEDRNuwnNCvk
 BfKvnULEQer8DP9jNrJKUFxZovoo4XwwY30sub2jF3Dc+Qr1+jJOHexzUhZK25vw1Pg8jpd6jv7
 9iPGPHyB9oFXzl6xiA6zG1xoC9hDDi1PzcxUuQ+JtWwvRKMKjhVZa4QJ9JIZ6EUpQ7ylBtDCPvn
 ctdDfnZDLNPNo5xg==
X-Received: by 2002:a05:6000:430d:b0:48e:56fa:9645 with SMTP id
 ffacd0b85a97d-48e6e30430amr30643269f8f.29.1793701523655; 
 Tue, 03 Nov 2026 02:25:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7246fsm24586210f8f.19.2026.11.03.02.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 02:25:23 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 10:25:22 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I49777902951d3a05c48cddd0d33c14e028e5d706
X-Gerrit-Change-Number: 2047
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2047?usp=email>
X-Gerrit-Commit: 02a7ec1c6c820ac205b9b0f3d673dad7c32b0d3c
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 10:25:22 +0000
In-Reply-To: <gerrit.1793094393000.I49777902951d3a05c48cddd0d33c14e028e5d706@gerrit.openvpn.net>
References: <gerrit.1793094393000.I49777902951d3a05c48cddd0d33c14e028e5d706@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk0OTc3NzkwMjk1MWQzYTA1YzQ4Y2RkZDBkMzNjMTRlMDI4ZTVkNzA2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3669292363835f4816a64a7bd3815d6021511ed6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOBhq-000000007v7-1UZE
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: resume
 deferred auth through multi_io_action()
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
Content-Type: multipart/mixed; boundary="===============6206661076140615423=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6206661076140615423==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J9g+mNThnZA="; charset=UTF-8

--J9g+mNThnZA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2047?usp=3Demail )

=
Change subject: multi: resume deferred auth through multi_io_action()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2047?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I49777=
902951d3a05c48cddd0d33c14e028e5d706
Gerrit-Change-Number: 2047
Gerrit-Patch=
Set: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@mandelb=
it=2Ecom>
Gerrit-Comment-Date: Tue, 03 Nov 2026 10:25:22 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--J9g+mNThnZA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2047?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2047?usp=3Demail">change 2047</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2047?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I49777902951d3a05c48cddd0d33c14e028e5d706 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2047 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 10:2=
5:22 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--J9g+mNThnZA=--


--===============6206661076140615423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6206661076140615423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6206661076140615423==--

