Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A328606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=io4q+vTz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Gx/wtTZG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U7GGI1jj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TTO7d4L5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=U9t0iabk8G2pPJf9g0LDZwXu65TBQo7AFBYn/WjI6tU=; b=io4q+vTzyUoPeIxJDgFPyxN1bn
	pAnLGywqOJh49t9tBAVUcfk9/qkIn1X/BmqFEpEkubQ966oPA1rhavGOyCTpWKHvgquPxoquFyi7C
	gFE208O5/bXEA9VR3JkKnpEimgDDJ0Kux4qKn7D2fiU2PkWgzXeHWNS+LdNAH9Sq/xCY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrew-000000004Zt-1NbA;
	Mon, 02 Nov 2026 13:01:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNref-000000004Z5-0CZo
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:00:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Mb3NwQAUSbMzbWsQRYKyUByd4T6NefhgMKh9zNZ44Q=; b=Gx/wtTZGN2/fzVtGaowUt9HKBh
 U5EpZeYPbxssW5IRiya4XI2dfXYdjHZ8AuRVEz/yFcMprAqp9KT3uI+BrgxUi48scqe6RPIB+Xbv+
 bgqnCpW6AoifmAAADrCj9+VEYYSmaWcZvCvqlDuSN1W6rG4iUhAZTUBR/mjQB0v7MhoE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Mb3NwQAUSbMzbWsQRYKyUByd4T6NefhgMKh9zNZ44Q=; b=U7GGI1jjW4CPJN4B/NOVW3RlBH
 WzNV7Vu2cYSp2QL9dDxwzheV7K6161w00oA5HlvVXLCLC1BKyDXYiQuBvi+y9t64UxqFWyq17/aU0
 2sjGaZ27T81TmQdIw172AThvLHlRqxwWYaR9qL6a9VsICUumKrVyPBfQp37DxI4e9WGE=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNreU-000000007no-1Xzo for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:00:43 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so18780695e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793624436; x=1794229236; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1Mb3NwQAUSbMzbWsQRYKyUByd4T6NefhgMKh9zNZ44Q=;
 b=TTO7d4L58Trv550lb6+D+OhELbEYmJBH90oPwHKv/6r4j9gqI1Mgf3XUage07SWxD/
 JLLeS/5ucrf3fxDIqS9WohmBOBBhIdXqyRRLX853pwl1iluwDVwh/EFgXXoCX0HJ813F
 tjlK1QUAkdLDQYqzDES0Z3jDMO5c0wTtqAOj0pMnT5TPnjrLP1wC+VvJIIDRyr1dFPSR
 TTG6/N8Zf1xpUPOjhN5vqOiIHSSPyBE6u439+9NNwU0PwK1LnHH7TUJ5V10pKQH+756W
 RQyH3UhvweS+X+mt/J2n+7FbBSXYAnfJeaSOF0jNf7rvGNBaoqKu31Q3slLdBsGJXEZH
 Euzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624436; x=1794229236;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1Mb3NwQAUSbMzbWsQRYKyUByd4T6NefhgMKh9zNZ44Q=;
 b=LTYWXldhqJzKO2lrv8x+aAhjn3veLD7IAV5ghowrV+5t8Fk1NCrERZSUDsghFZBDQZ
 GVhgCUpvY9ykci0wF+BQ4O+33YJhjcOVYmweFut22KDFgpaeEC/lh7RD0G9SYbuAhykA
 YtIfIf/NBB8kcI/TP7hJ+5fSqBXcPS/5VEciB6gAP1DCdDH23se9tiUfgMStNExWfBZl
 IWYZ6bdz7U7nQpwZmnfStnwUCp43vdim+6xqK5BFmsFVj0qkjE/lm9Q7hZlhpQm64THK
 v7UMcojM112g/JWIZ8MGXZLAgfiwZLCUljicahvm6rCw2M89Eo8UKhRshjwowPTVhkgE
 7FXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhV0EWDukGX4MhybljecIfZeFXMu9sxM5MvNGOYkBjV+EqlDlpehGZMHV2Ucna4xl5o8O8g8W+vAWX1Nqm@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK3fLAvoblWNPKDKLVno5KjoXlQt5F12ubW5pgH3HrmQdg9pM3V
 FZnQ+5JLCmo/VRpKcjU/jXhqbEGrbXMcYL+whIl+HcYh4AWr4AFYYc+vVI/Yh/94mDgr1IxeZRA
 OviFnnQGTwUzjnaJy7GobbFzkw9A06KjbKssfsSKIETFJz9x2CUcGD0leL8BzMhR/JfBE
X-Gm-Gg: AYBFou1QqnxHak4i6dbijBu7vF4PUXJMS7L8D3QJr+9TsBqiVdk13mWZmtj1KUeGQgS
 lDDH/6JgxuXr61vWWJPfo8ZfW5/SsvyItu35/6D7NylijEjO8VqFvNzN3jJgRuBViFeW3T0tiUc
 GOlHtYmW3AjEV0TE3YAZtXier4IVSyEtDQKBTFgW4jAB7dXAxPgsVtB5Tb1oAs61kmEb/T07mF3
 NWNzQiqUdVNhn4ddloKWfYL0EB52IW2zEuIfEgAKLKCFF1LpWH7EMtuMZdcyUyhvFS4ida/ZBCx
 TePIvAdxwDspMU7iXklNUYbp6YGbUsDLkqoHGtJHRHzegVOPcXEsVi4o+yzlbtcswa+p2AUFt9u
 coz+J8Ks24lQiIDtlEp1cuqrHvo0PrHDutQzIp/5N5dXU6mrhpE9MhUlTOIuVniGlh4qMLMRVUX
 mv8RLl0CvvO3n0siWPdzs+aue/dL412FekYIaOxrieo5kU+okV7v7cCOuPmAojWMxiB9QlwCwnw
 K8mFAnffPUE5KrD0ptt59kY8cSPATTXQDHqMy2A1VqTrov6gcjO5kgmz3FzV/Jr57Y4jpnMyjyQ
 fOeQ52dQVp8H0fJyzAM/Vb0PBSdz7GnRU4GN+ZIqdEPnDTYV305i5PnRdf6X2ip29Qnkz1eyhlW
 WdxWIbGptreXiIQXuLkXyZbG1DxiDvXS0VtDyNnwHCHQy0iRTwL2mMRoViqVeLdyROOesvghm51
 j/miaH3CXiubB0rQ==
X-Received: by 2002:a05:600c:1c06:b0:4a2:fe11:9a8a with SMTP id
 5b1f17b1804b1-4ac121940c8mr297112795e9.0.1793624435104; 
 Mon, 02 Nov 2026 05:00:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6c76507sm290827995e9.10.2026.11.02.05.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:00:34 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:00:33 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e
X-Gerrit-Change-Number: 2077
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2077?usp=email>
X-Gerrit-Commit: d1b1dff10d81d0fcfd57a74dbadf2958e025c98c
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 13:00:33 +0000
In-Reply-To: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
References: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzgyMDAwLkk2YjQyNzg1ZGU5OWVlMWU2YjU1NWQ4YzVlNjFlYmUyYWU3ODQ1MTBlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c9b5d5fab2c3c5260ca2709499231bfbf4f66721-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNreU-000000007no-1Xzo
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto_openssl:
 Clear PEM decoded key data before freeing it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, hansaemw@gmail.com, gert@greenie.muc.de
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6646678027420534500=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6646678027420534500==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pNk5W+5iiRc="; charset=UTF-8

--pNk5W+5iiRc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Hansaem Wi=2E

Steffan =
Karger has posted comments on this change by Hansaem Wi=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail )

Change subject: crypto_ope=
nssl: Clear PEM decoded key data before freeing it
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e6=
1ebe2ae784510e
Gerrit-Change-Number: 2077
Gerrit-PatchSet: 2
Gerrit-Owner: =
Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
G=
errit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Hansaem Wi <=
hansaemw@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 13:00:33 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--pNk5W+5iiRc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Hansaem Wi=2E </p>
<p>Steffan Karger ha=
s posted comments on this change by Hansaem Wi=2E</p><p>Patch set 2:<span s=
tyle=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: =
4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail">change 207=
7</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6=
b42785de99ee1e6b555d8c5e61ebe2ae784510e </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2077 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Hansaem Wi &lt;ha=
nsaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffa=
n@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-D=
ate: Mon, 02 Nov 2026 13:00:33 +0000 </div>
<div style=3D"display:none"> Ge=
rrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels:=
 Yes </div>

</body></html>
--pNk5W+5iiRc=--


--===============6646678027420534500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6646678027420534500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6646678027420534500==--

