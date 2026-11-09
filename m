Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6204606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mEerK32v;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UzwEGpl2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=B/2i4BAS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IhrCBDJb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ynp/mZ8y8dKXI6OHytWjlDnTwhHHCLVZeJ8+g9nl4yw=; b=mEerK32vTtyHNPPd0X4vv770Ar
	nmqaXRkyc7aLUT/x/SRXvjgnPf5RXsWTYbVagIce04qOAmEJmwoBIn6g044Br1a1DiEz4MqYb8NaT
	eJriVb2GBWfH+GVoFkedJHMtsHLv7nXJ3OmGcEI0L/c0J7xJzx2OmLQGOGmgDrX+PIwA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQXKc-0000000006v-1s03;
	Mon, 09 Nov 2026 21:55:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQXKb-0000000006i-0W5Y
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 21:55:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jUcmzuhPFkbqpC9QuRzi7CBR6U5SbCSlKG7fpL+z63Y=; b=UzwEGpl2jOuLxKc8yOaBqiQ5Xt
 3OptKZlsPNDk8odWf4mWcg8WIIdm+Fym76QutkoCkjb206vpvkw4RdhP2CJWZ3a5D3IU8TpKeOBOv
 xLJbFi/ADn65aGeOqLHpSGeO23AxL5jXAs0ygmnN7coG9dfDU4z46Kna3Z/7Q4iuIXa0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jUcmzuhPFkbqpC9QuRzi7CBR6U5SbCSlKG7fpL+z63Y=; b=B/2i4BAShIhEpXUQ8WxutCwKbf
 laUEgmCVcBkf9ZrJDJFwzP1DJVFkbhJjFJIQ3Qihi3Opq/RHfHCAQwJHiBEFLa08axLwWi8yShf8/
 3qN3ZpTeNNkVSJJ3dxH4tBoBHh0hKxXw1Q0Z/TFp0OZGEXyyxnnJ+QDJWZYKZzQCyr/I=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQXKZ-000000002Zk-0hed for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 21:55:12 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso775073f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 13:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794261304; x=1794866104; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jUcmzuhPFkbqpC9QuRzi7CBR6U5SbCSlKG7fpL+z63Y=;
 b=IhrCBDJbTBx8OqnxzKttesUEAjSxObsmj61Sf1Lc2MZ9sKjINJtTCmr0qCALLun3sX
 VxWwGI3e+vRqvdGEpltlzeqbmrH1bSQcY+hozp2o8lFwTtdinlrUE/b8Ho3DwjZZzzm6
 +zsBegbZiOSvDQsA5OLCC4L5GpLbO+e1JfShIRtZeIEg0yey6Tq3Eme+eAb1KwAWeBEg
 uW3Ecg/0r1FNQOUIGOIS6q5syytNbsJiX33PJo9MbIZeVNLLWfydQGlYFujHRxCoeZJr
 nIr7gntiNjq5WefUnmgBB1VrBZd6MPEAOm1/in/xzj0/f/wNKeW1tVVClnLZ+ndrNc4w
 y9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794261304; x=1794866104;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jUcmzuhPFkbqpC9QuRzi7CBR6U5SbCSlKG7fpL+z63Y=;
 b=DdEWGlJS1Z+QFMPOZBb8tJIvQ+JJl+MVy3lwjFQB35FjTNqrzhka8SV8auX088keb1
 5bZ9NVsp5UP5lgVe46BP4llvb5suAB1ePxDmcqXQSoYaz4bjMDXqtho3lmNYbdAJFZcL
 +XC18GP+cN2SgxLx9sY13RLrWUIWQ0oLvSZX2d6noTCBkMqUKoIFrKOGarcg64njvsfi
 /SJb769KWEZiIPe7Wto/MG4hSC3toRs+Pi6OGCXavtiDt97dKpKoVBYKh8mEc5tXwcta
 ZTspRhuFv5LJeSVZvx1IYDGGWewjvLX5otoshcCz5QBIWyWOj97m8jT5AHMjk6e+bAd/
 Dcsg==
X-Forwarded-Encrypted: i=1;
 AL+hErHCHxXImwYYm1VEUUg1fKBxaAyJQocHpv2PaLS7qvDGhohcN33CiFOVdEJds99c1Sc7c9MksUVV398YalrD@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+ytK65oTC8qkjWsw4BFMyYXWAJyRcPtZyiAiy1ErQ3tQIugEAt
 KdNq4+y0mXj9pxjBhRvOR0cdM03vJz4vBn7nItgEFzTy489/7KwYsIQmgmlPdFSj6uC5y66G7rp
 1OPaeRjKPM49ElDVJpYl3aOghNSVFjm+TAIsfLJ6BvOksgkP3DWyS9S6xg8Hx2JTMzvPo
X-Gm-Gg: AYBFou2Lizrx/Uo9lT67a9ajQMIOD0S5BjtbsCcZBXm28EKBl+nglgVebGSpWUeAjQe
 OSI2wGm51Tu1HNQP0SFcfFJx/lv540IsstaU3/syuHlIsUmqQ2Tk0lBFkvfehyELp4pJVzthlOH
 TqL85KWcgTIATvwp7fIpETDCNjfFEwsUWf1+S5wlx2oDQcdtm7wrYjIZyTszXX3HqPF5F1Bniii
 PhxyQ5pY6GtlaX7EbeU2VkmY3+foO4OZ3ErmCJ8ndVi9ZFoUpqmjulQIpS4DOW0AwJ1YIT5UXsm
 xyw86ahJ5pwFZyFCwUFNBMnJQc1JWzL7fvYySnKbdBgQ7i1mcSIle9Oezs64Ous6Xi1BjqZUat8
 IZOa3cWUTeKwvsDYybju+stViBXdiw/Rb6dhbUh7gdwqmsmrZxwTXabgoNwcm2kQFhxEey+ckHe
 cChiAQUBAGxDV3IdXWdXjhmwbxZxDCR1pOou9kDjG65q0J/CjrJAArfEY+TlI4Hwp8aqg5gVNuN
 VrODrjgkhRjuIx2w/Tt1I+dggK6QALf2QQHpl1lq1Y1sAayk64BaOnOIMOz85IxibuFXp/h7vNu
 QKvUgpInGoxDcI+sMjpQX3ERZVok5oS29HYIZyWZ8Q+OgP8meSYoWhJov0T3jN6FiOwEVAxooTr
 KWRZbCV6l+pJZOmVLC25ZzID26LvJHzjbOPZv7ppHfZBd1I98WlHZ2JWiibtzmYow2tB4XEvjel
 LucI9qLptDYIQFeg==
X-Received: by 2002:a5d:59c5:0:b0:490:d197:bde8 with SMTP id
 ffacd0b85a97d-49827fd2311mr1503413f8f.0.1794261304376; 
 Mon, 09 Nov 2026 13:55:04 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835c377fdsm1000870f8f.21.2026.11.09.13.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:55:03 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 21:55:00 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: 1925c00d844bc582a077930e3d8727ae88cbab3a
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 21:55:00 +0000
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2750b5f7cb9e85393f15a805af1aad0eea220ee1-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQXKZ-000000002Zk-0hed
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 --secret
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6086098082917405111=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6086098082917405111==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xJSNqexgYhA="; charset=UTF-8

--xJSNqexgYhA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail )

Change subj=
ect: Remove support for --secret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 8: Code-Review+2


-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
Ger=
rit-Change-Number: 2081
Gerrit-PatchSet: 8
Gerrit-Owner: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 09 Nov 2026 2=
1:55:00 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--xJSNqexgYhA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 8:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">Vie=
w Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Dem=
ail">change 2081</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2081?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2081 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Mon, 09 Nov 2026 21:55:00 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none=
"> Gerrit-Has-Labels: Yes </div>

</body></html>
--xJSNqexgYhA=--


--===============6086098082917405111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6086098082917405111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6086098082917405111==--

