Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738FAC5DF8C
	for <openvpn-devel@archiver.kernel.org>; Sun, 23 Aug 2026 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m3EzIFl1B8eIjb43fRWuqFngk1JTHKL/wvBzcFXIPOY=; b=AU0GC+MEeAROppUejg/dfmyVxU
	5phaFZu85SERPzXajWRkZV/OS43am0rrEDxQoYdFITwE3uN7i9G7lCBdWlB0L+wnC3rz3x9vHWflr
	RCCvaxh1A7CDBb0vMoVQRMhhUOUCDBOPI1OzTLO91w01XwAPjsqGkRJUoFuWkprz0aFA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wy8Kb-00042A-6f;
	Sun, 23 Aug 2026 13:33:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wy8Ka-00041i-1U
 for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 13:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=d1p3PX6cY/q9VT0HJtoOBPbJKQd1MVjHFwu8PxS8mwU=; b=AN1JjqF0MqtO0hCK6G2XX6kNYA
 W/c2jck9o52j4UDInsHdbtNZnLtKTIY5OB4/OiRW4auiELQIHtIZL5Pi4QuLHu0hdbC6towBTA6Ik
 bQU/ys1iTmv4hodXzbipmcUTm9wJnJe70cHKZE+mAFLzT+LHetuSlOCTupY501OBoBvE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=d1p3PX6cY/q9VT0HJtoOBPbJKQd1MVjHFwu8PxS8mwU=; b=a
 WmupL8EvkjGbSp6PEADbIdZJeB3Wr6SfjT9NNoxyUDJ2a50BlKgpzdaVfbT4ZgQ4v2MjAp767xSbv
 2HM4Xb/xv2EiYoA1y5v1QtxiiKkT3Xjx9CEglGwXRd5apCXSU7lvgDsSBmPlYq9riLKZtOlXxLif8
 mkSQQ0PC6CzW+JCM=;
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wy8KU-0001RU-Kn for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 13:33:43 +0000
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c15f020a223so372891366b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 23 Aug 2026 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787492016; x=1788096816; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=d1p3PX6cY/q9VT0HJtoOBPbJKQd1MVjHFwu8PxS8mwU=;
 b=IVj3cZWexChLDIb/INKh6laXmLBhFaUXzqxOo6qklSCeFAbvyIJYt6PlAK5Fd5ZKXX
 KpeglDP4RoDbdG6ROQBa2K6rMk6/OglTmQYSc9TNkWoS56XYOmoaLgK9wNXAp0dZd6k+
 GqrbsQZqXSzWWlrYzYppHKUainusMToyqf7ESHoaAjURXB+148knOtDKiSYrVm6zbMcK
 u0lOkgiAzXKUC9TcFFlFWDavsmvKm5kfxrkh1UXlPdgH6wpnPIiP6EUn27feptf6vt3b
 ONW4luTt6C3W0DRSTow07CsgSvsItmn/tX2nq+eTyxaXwzjcvBMyQuffG3K5gmh5Ns+s
 T4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787492016; x=1788096816;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=d1p3PX6cY/q9VT0HJtoOBPbJKQd1MVjHFwu8PxS8mwU=;
 b=FHX9TtIRmZsYq1v88Ndnarv5g/IxwVjUH42vCKwqG/jm2th8Y7BFY/yJtPUWe+F2xd
 9B1fFmZTqaOPS5rA9onoeB6aYN8aMMfKpSpHGN3htLPHGztuKTTDtMFd1tdnvmtkNA2S
 TQ7Y/OVk6lBv0PFC9QcEjy9NV4i7foUac6ro/pbaTL8r8vWwvHkvk7yGwHftQGlyr2w8
 /ecsKiDy5deHCv+KgtpZ7osUIOAjRZxjVEaAJ0spBQW5yTXBVeFUCkOLX0o2W3OHyxZ+
 BOcpd9no+S3M6F5n5bcwvEUooLUz7Y7H23fFsHk6w6j1SWqwxHWvHN0KtsEPT0nB1V/m
 C/Pw==
X-Gm-Message-State: AFuF++k7T1mTHYr+7WNTeAy5iAhjCzMgWSJwPoe8Y18HN2F4wTUCJ0sn
 hWLSN29Z94IBDQSR0C9RA258wnwgJa9dBEiyvpsioJ3jF5t/GA0ap3NJKI/26/J2Ndo3BlxSbb6
 JHWkHsSsRHk+AE5qkpquay8b1QdWEjDNOnRCkieT3yWtoBD8zHqcFKnqGwfevbPO1MbKs
X-Gm-Gg: AR+sD13Y06OqkH1yXQQ1VysIv91eodj5Fv9hiQ6rZOBVOx6PNWj9vrY/i92IuHu1dnw
 DR1KXvGdlpYh18wxCFGOEZt2K0Ru5qnlepUY6ZJDkSnPNYH0W8+Iq2Iibt8k1y6x7WEWEk0PF0O
 O08IYScUWdkcMjaDTng6tUZYOmZQ4Lj3OC+DUzV2ZTB36Bcv0P9YTAgi/HcbKrP6pujrof0VZTX
 2tQwFZV7e38VDcOCOj1Xaoyri1MAk81n09EUeO9l/b2y7RgRFpMEZszI1japNkfz9p818wmbf5K
 Gw4guJrVp5FCvJXhJaNNkV0sQqJGygf3iTGt5u7ffyRzQTASKiw7f5kX1TX7M2XlCCkSHud5S23
 vipff/nSyS8C1W7+hEOcVwkFeTSeebrWBVUfK9IeaWRYGwgwN+Ggz5oIDVnWq5QTbI2+CNPLRTN
 0qt3t62wcVYqJoaoiXOJXevJB54vrqQrU+iQZLJopuTH7FxSUQl+b6JLUzrlot7G5acJGtRuGko
 sUU2TLVIQ40HuwVtivunn3XcDN4VaV3GvtyWYF1ijwXPVD3yM0/51QMkPLaUPe8B6LL56k+wedC
 45lvM7MY4x0WAWE2l0GRca0phr9s04t4SZkDTaaghgFdx8p42IM=
X-Received: by 2002:a17:906:fe48:b0:c15:fc59:cdf3 with SMTP id
 a640c23a62f3a-c24b3ebee48mr567435866b.12.1787492015774; 
 Sun, 23 Aug 2026 06:33:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24962a3c13sm823681866b.26.2026.08.23.06.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 06:33:35 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 23 Aug 2026 13:33:31 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd
X-Gerrit-Change-Number: 1851
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1851?usp=email>
X-Gerrit-Commit: 9dd3b5c423fc8a8843390f50e84104bfdc777870
X-Gerrit-Comment-Date: Sun, 23 Aug 2026 13:33:31 +0000
In-Reply-To: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
References: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkljZDUzNzQ1YjI0MmUwY2EyOTQzODYzZDViMjc0YjJhMTNiNDQxOWJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1fb4ffa1b2c69ba64f4e2849a1f1c88923ee1060-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wy8KU-0001RU-Kn
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make
 pull_permission_mask return uint64_t
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
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0242284205207070020=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0242284205207070020==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YKodUvH1pyg="; charset=UTF-8

--YKodUvH1pyg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1851?usp=3Demail )

Change subject: Make pull_permission_mask return u=
int64_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 3: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1851?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd
Gerrit-Change-Number: 1851
Ge=
rrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 23 Aug 2026 13:33:31 +0000
Gerr=
it-HasComments: No
Gerrit-Has-Labels: Yes

--YKodUvH1pyg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 3:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1851?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demail">change 1851</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icd53745b242e0ca29=
43863d5b274b2a13b4419bd </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1851 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 23=
 Aug 2026 13:33:31 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
=

</body></html>
--YKodUvH1pyg=--


--===============0242284205207070020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0242284205207070020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0242284205207070020==--

