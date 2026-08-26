Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60967C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KGKzn21ZfedGUezBoao7XCFIAOVhHm7xE8+/u7McuA4=; b=O7khpYCT8tkgX8pwPYDY8KbQPg
	qcL6nItRyHtOyRVBNKAsQ9sJE5sO3C09SZrUmQj5WcXMrLkq/e0GGLiuaVgInOSBkq3ef0Do7M6PJ
	quUxHjbN0uSnONLnh/TeEr4WcR6xPA3F3EGWhMEQM2DkYu3LW8I6pB3siGnBad8n7d48=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzFdS-000357-2n;
	Wed, 26 Aug 2026 15:33:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzFdQ-00034y-Nb
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:33:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nX4NImk2pwoRR477uhPTFpo6rLflcgrGQreFF5LMM3k=; b=IDbcP2B9jbTcKwBeLIKK4t8Rgj
 WtlmAO3w14cfSIiAEuygkRTnDFFYTgP02QPmoHGAV3HxXxwjlDDGHxlCo1kqMwNsjbTMFU5E73LKu
 xsXuJr/KHVEo3IfQLVg2HOcLY28YpkDyTYJue08LKhHChwVZnPu7pWDRzpoOCj4fjAmo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nX4NImk2pwoRR477uhPTFpo6rLflcgrGQreFF5LMM3k=; b=T
 yFy7xCnSdinYp5y3OGdnWsJTpO80eznY6heB4qR0MTn88WspSjxPFEBM0ZZeDTxB53XdL9lXJ+RkV
 QNV0Y1ABYSeJALHsP0wmDo8x5sNCDjfoqL+O58UweJlcKuKSkKUZyEVJ79DiK2FF59BgwX2j2XBWF
 60alJRS4dVWVXwko=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzFdO-0008Hm-MI for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:33:53 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f84023916so886980f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787758424; x=1788363224; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nX4NImk2pwoRR477uhPTFpo6rLflcgrGQreFF5LMM3k=;
 b=FuXbxdZZqqHskxeauU+gVB48ZbkXpZ27wDr7VRtkIlMMRZ4iMrXJQSv59GwHDl4d8U
 7ysudMOEsWfOmGjIpUoKxcL6zs9tKo/FZ7wOj/0i0TF2P/m95uIMuwqbnbSj9iPzhJNG
 judEUj74GbhyIfPwaO+MIT+8VGURZFo08VqJfLWM/+ACipmtCmcm7gw9LDxePoUm3SUJ
 JBwjTcgC3EztkUde5Ua7BOidqKMXOS6IJgYyHt6Gl+RsTpIlqdO4g/6LZxdQjlzuxtFv
 PbscI9k/DHDf2u/uR5rlzVHbAhNYyT2Cajs1qP8w8hQq152VGd925l3t1mk//z/6vNOL
 76CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787758424; x=1788363224;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nX4NImk2pwoRR477uhPTFpo6rLflcgrGQreFF5LMM3k=;
 b=fWI+15wiFF66aXh/ATbqSID7z/3fY1Z6raNoV0jyJrfevVDj9BOgffBM7rmi7bGdna
 sXfoL9UGQfMBggkRxKaU3JvKDjtFMFhhf3o2g9mrnTTo2Q4rao+4iU6XGh9hHrMJnG8g
 CNUDb0HgUB6WhZP101SHRkWsmKiW0RuUFns6gBitbUZ3iQ4jHfT37saWVRjDiQnID+LA
 Lz1fWrGZvJgIqjcZ19WcoRYJtOqjwE7oYfuyBtGNWzlcT5B/gSXh9yufcilajTMMZEa2
 N631vBPwLAWRCblVTIpnD6ITyV0kflwz2t5ca6fHqweqLLlFlN+Z4cfminMwyKnC8g8i
 +vMg==
X-Gm-Message-State: AFuF++noeG3onfVosYchXReukY1s2XWAkigphwOvuRqG/ukTzk5It2ao
 wMctSdg6BBADnOqJbFxzjfryEZQOoZEHytc/h4BWlGgEi1DhgeG78E9R5NWEBLxc2/Y4TNhJhWn
 8bOoFFwwj9q0veem+Ty85+qrzl0QPr1THgwunzTKf2RXCQWybWqZEAe7KdWi4kUqnQ7HEYEpu9z
 DbvDyZMA==
X-Gm-Gg: AR+sD10S82hzOiTZpr95Y8sAJoCQ8lcg2n0m2bYVOzniWSSXyurEz67SGakHlalc2Ne
 soyNdgAPd5QMjuSDaDm0Nk0cujObU0WccfEKaZPm0woifck55vLyHN4kuSOE91fz1m7XWpUUqRC
 gZcnR9GFELjeUk30OLtXuNIsY5ZUuon9Ge+GkQzj6ABtTVkkGy+ZugWYBGy8+TcwDS/hbX023h8
 DhAHewSHTjpc7a0GzP2oJRyEzOgU9O3VEapAt5EN+jEEZX3if6TpEGcF4pX1YZ1iJIWb7Pt0jIy
 Uhdi3Hv0JYj/DVEFYOiXJS4eXy3ZC4buOejG07jEafOI4sst/Cw0Q0i5zPVw9MvDOTmw6+9LegH
 ZLTA8T5T1abZFbpsQ2pdGyHdDteflb7R8VWG/McsKvBf88KBAYnPkwVqQqpg/YlezraENU2bGqF
 hjkiBqH58pBjc27Hk1y7TCWqCIpaR1leMXKu+oXBkAthi/Eic6IYhVyI6uO/0iK0pAF1PSE4rd3
 exzXwyfyoIoOrgcruU/WBWyW5H4D43C5k41N/RdMo3KmKnAXT1lEE0uyibKmvkLKHMHGYArA3x5
 +ZiMlO893edxN2z7ot+05LTChq1FtMMuhRfd6MDRXaasBymdtl8=
X-Received: by 2002:a17:907:3d4c:b0:c20:9447:bd5e with SMTP id
 a640c23a62f3a-c250bb7da73mr865683166b.9.1787748630125; 
 Wed, 26 Aug 2026 05:50:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a6fda44sm545855566b.14.2026.08.26.05.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 05:50:29 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 12:50:27 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb438
X-Gerrit-Change-Number: 1854
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1854?usp=email>
X-Gerrit-Commit: e0339c7bc904dcd9782670a7c6fcf4342234f582
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 12:50:27 +0000
In-Reply-To: <gerrit.1787327336000.Ib7d9aa61fd878d7e025e9d1050c563dd114eb438@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib7d9aa61fd878d7e025e9d1050c563dd114eb438@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliN2Q5YWE2MWZkODc4ZDdlMDI1ZTlkMTA1MGM1NjNkZDExNGViNDM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <67726dafc4d87d633996ea0cab0d53f39bbebe51-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzFdO-0008Hm-MI
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Factor out
 lookup_session_by_mda_key_id into its own method
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5763192085869631416=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5763192085869631416==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iM1e9VRG6vs="; charset=UTF-8

--iM1e9VRG6vs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1854?usp=3Demail )

Change subject: Factor out lookup_session_by_=
mda_key_id into its own method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 6: Code-Review+2


-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1854?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb438
Gerri=
t-Change-Number: 1854
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, =
26 Aug 2026 12:50:27 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--iM1e9VRG6vs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 6:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1854?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1854?usp=3Demail">change 1854</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1854?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib7d9aa61fd878d7e0=
25e9d1050c563dd114eb438 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1854 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Wed, 26 Aug 2026 12:50:27 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--iM1e9VRG6vs=--


--===============5763192085869631416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5763192085869631416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5763192085869631416==--

