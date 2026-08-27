Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD94C61DC2
	for <openvpn-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vl1/EAOq5IDsSj30Hn2TMwu8+vQamS1RzehiwpKAayI=; b=aYKLoE1KCNGDAFIBgu7Jrt1V2K
	51iKfBzHStFfbWk/oaKIb21z+XoVozTwqMOCJ+nxPvLedz+cMXvglLYNbeqe/rOH0KcQEqk0jdlMg
	rkvf0mHi+YNE/HmUMy/5ewW8EuPhF2PUPhAwX4+BXOPUT8fuLzy5ECDBZRFlzwP31B2c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzYqR-0003cb-MD;
	Thu, 27 Aug 2026 12:04:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzYqP-0003cU-Qe
 for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3XSLlfM7kqa7u5muw+nc3sgRcBf1MIZJagiL6Yswk54=; b=QbEEjSYomPGj6eicDgzCjFWIiT
 bGTHF9efp5uIo/lciDH2UjkvqHDAqf+Wmr26ljovkJZgd70DY0YYGma5zPUUBxKO6Df2u59R4eWLi
 ce7tMvWzkonmy3QQaXxyvqYYNMHDooriPTpGZZ/lCnREsslewoNEJ4PU9E5ccGr1f6fo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3XSLlfM7kqa7u5muw+nc3sgRcBf1MIZJagiL6Yswk54=; b=R
 icoKe8wMAhGv1nK4QsEE2nserq8ap5Z+DrY/W7JmkmK2UNIYasX1AWVeqDTAH0OoWz8RJX2E6Plem
 qKWkQ6VYsqQPnMn6HPFJnaZO19pnb0EVv6E1D6ZxLp0U8D0077dJdclQjWK32FDPbiB2lurKdaX/5
 XztPvZ4oKWbQkQEg=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzYqO-0002gl-Q1 for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:04:34 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so321702f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787832266; x=1788437066; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3XSLlfM7kqa7u5muw+nc3sgRcBf1MIZJagiL6Yswk54=;
 b=WFEfLlEsiuLgPKeUnCW/txU3xROZDkPrZMspz39A7rmMweQiL5hJyGFJRG1oQY0983
 Ob8xvHmDu9g6vqKl0InYjHZULf3tvcOkGsEmYJi5g3yEeAWAbFC36Bqh15X8i0/K/9pg
 70SSLeonCDeV+MaNqh5vY86WGmU49my64kY1eBaTbgtAU5CfoP4C0vYOEki4tNNJ9ojM
 l5Zvx3e2VZKk0Tmy/Y+2i8qU4VsUj5bCtS8Tva+Sh1aK1KYWurRYwEJAZlmNohAPM1z+
 5LykLOTgfvFMNTpVNR3i4mHY7b2HhVcvi0Z8h1l5SEKymfHQwawrN4f6qV49ZEEaUAlq
 /xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787832266; x=1788437066;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3XSLlfM7kqa7u5muw+nc3sgRcBf1MIZJagiL6Yswk54=;
 b=BvvkWk4a1wmnBQ1kEm56gCH6X6qc5FYmX9RfdSOfoHbzHjqMSVfKMnXIRx9y7CW0hP
 pgHWQyvWavy58tUtOJ0mB6BEKkMLlVrbeiRSBJ08kVeW3ERpl/J57ITfBbD2BvolplYx
 fzZV6vP0mrrzh5S+93YX1rvQWk/APmfWzAZMU1pwR6k9MCAKl2OIyo0aZJVcmN661Qjn
 yvfKF1iYoa4fWwVWzKqsEdX1qqvmovmK0YKiXT8mKSfNUBvJsXtBl2j9kSdLjOj3tFQw
 6xzADOS+K8N3h0e9U38TRIhs+FZfl1quAito4C6Oq8g/NPibmbWkasql6vl72V5XgZrM
 JkyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRXNHkotRmA4Ozesg21/pJaPogH2kkN2zP3ihPqT4rjMylthQ3qd3BuU8ynHy1uXc2F1nGYv8il3HVk/he@lists.sourceforge.net
X-Gm-Message-State: AFuF++nmL0oWKf2PR0Kxbl5lrAyxoVkT9HbC3+cwUCBdCzgAhE9Ng3MR
 2NsSHn0qUjzPIBrFxW2ewX/PJA6LqPLov2EKJZJEKGvQmUJM3T8lr039ee1tSt/e4DUOvhBg1SA
 ldM0KaPELpb3Or97lKgp8R9Wm2NcFp1WDR65n+BiXNg84fAhT150VBvAdIMzd8Xg/+d0MBl2AiG
 8tAhAejQ==
X-Gm-Gg: AR+sD13HbPPcBdeWtXp1fb7kLxcngd53ZCdEryuSQo+R5LZNu6UoYvm1RypJp2cZuyb
 asUHIj5F19J8AY5X4AI+khsC/iik5/dMKnvUeG2rGOEBvGdsqnQEy+2Xv5WUXpK1PQaXTsZ4nhK
 ToaxKySpqbKE6JUSpWWIuU8dhEQoJ5MkRPDqsr/vb03YDU9oH6cG8sS+od1OfifMNKfbvCEKoMF
 BDX2YimkDHDqFo3I8X1xB6oRfZUR2E5S4hRgsi8CNmjo9BiUdh9ee7XkSn4QRNMuRe/PZA8PI0/
 RaqiPCzAkpHG7ioO2UTUlum6IMuT4JbMSuvQ7oKPQhG3tX3moA0LqQZDcYpfoSwkxQQ8h7NG6bh
 VpYipFqfWH/iCOq6OCgWaryDeSLXuLGOvenICS0b43BsM5iSqYntGuoQD4vLbiMBIDIBVzvUd+1
 tiIs+l0ytuQ0+QBOMYCkhnVvYyDw2uOzoeDOal82PqBHhRKK4xxSOZFu7lHjkOdiPk4uULDgfjm
 iefOq/0kugDIeUgIOathon5iIYrOtsH7ueDRaBvTE0GjUWODFwE+sHQSoXx0CvZUOfQ6nMv955I
 D7Tbc4dxPZdL3HivBVqIjv9inPy8EwKYK+wNMmUFPElDxkULhww=
X-Received: by 2002:a05:6000:71d:b0:47f:8d71:210a with SMTP id
 ffacd0b85a97d-482e26e47a3mr21268776f8f.15.1787832266174; 
 Thu, 27 Aug 2026 05:04:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28e8fb5sm8538604f8f.29.2026.08.27.05.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:04:24 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 27 Aug 2026 12:04:23 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
X-Gerrit-Change-Number: 1763
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1763?usp=email>
X-Gerrit-Commit: 82e151c45c3dcc67b2e25d118cc0326f5fa4dbc0
X-Gerrit-Comment-Date: Thu, 27 Aug 2026 12:04:23 +0000
In-Reply-To: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
References: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMzODUyMDAwLkkxOTA1ZDk0OTQzMzZkYTRlOTFmMTk0NmQyZmZkODc1NzIwNjA1YjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ee310d4e3c3fb08f57a65841ac24ae8d3c5bcfbc-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzYqO-0002gl-Q1
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in: Add
 utility function needs_openvpn()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2293993595092725434=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2293993595092725434==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f4Mj/p+SkLU="; charset=UTF-8

--f4Mj/p+SkLU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1763?usp=3Demail )

Change subject: t_client=2Esh=2Ei=
n: Add utility function needs_openvpn()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2


-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605=
b41
Gerrit-Change-Number: 1763
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Comment-Date: Thu, 27 Aug 2026 12:04:23 +0000
Gerrit-H=
asComments: No
Gerrit-Has-Labels: Yes

--f4Mj/p+SkLU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 5:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail">change 1763=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1905=
d9494336da4e91f1946d2ffd875720605b41 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1763 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 27 Aug 2026 12:=
04:23 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--f4Mj/p+SkLU=--


--===============2293993595092725434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2293993595092725434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2293993595092725434==--

