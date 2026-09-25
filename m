Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0ACC9830E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ufkGhpQdGJoR6vZrWFRY8TnHSfWAErSyTqKOwey62KM=; b=X1pywrWdbvf0lAQ/jPk40WCWFg
	+3qh1CqE3eKhn3yRJO9wqrrWgQugXLkyVe4l8PNkGin0RW5Ex2P2Bl87BeGBzvnDKzdij2F4ppA9l
	gOrRLRK9upkMQFoAW8NugGsDGWfkhs6Z7co01a+VgffSa4qnEXQYZsD01M7LRhBzqKoA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA7bU-0006Rg-5s;
	Fri, 25 Sep 2026 15:12:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA7bS-0006RO-Rf
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 15:12:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iLbomf/LmyfGvEfBahUDa0GVf+bneOFHdvbTM8f8PtE=; b=I+5AS7PatJ2SfXiVBNUvAXRulY
 Mn1dhdjiU7XUYg3VhI8Lcmv34jVDiWo19KtnYrl5mqFer4VxZ1x3nJwbnTssCC6LhUrXytqmFDRI5
 28dz1BCTyyOc8DAvvvY74qiXhmowZCm/VdyHJaE1nAqbS3u9NnoDa8/OWtCdQ1Ynjmdk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iLbomf/LmyfGvEfBahUDa0GVf+bneOFHdvbTM8f8PtE=; b=n
 Gd3gTxuOImiOpL7VkkL95QcsjwTzoEW1Uj85h+TqwjKWfNX+BTCYxtuSTLR+awXdGacfKkNcriHiZ
 3hpfzrKrvqCqHPF/U0LjL1mUnGRHYsHn4ER222niA2b2t3y2NvFZz9okmGSprPc1EEclpxgAV2WGQ
 FI4YrqP6L1+duKvY=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA7bQ-0001Zt-Ok for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 15:12:46 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so10393835e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790349158; x=1790953958; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iLbomf/LmyfGvEfBahUDa0GVf+bneOFHdvbTM8f8PtE=;
 b=ew1GtNuC+zGdlOy972ZFBJda6hU8gqHslPJP6cG4sPrppnrDlKB8f6di2YqfmDmwv+
 tId31B2Xn7a2TgWH7H+TwJyDy2Y7OekgB/D4/acSlubj6qPzYESIzxpAwQ8YDW4WmzRB
 AqXLmoj7hr1GO/8ngSoO3nSdy1aV2gldgwhLwVssSW1BdYp6YTzkkM1Lc1n16fSlzIn9
 H4MD/XmHQzYs2m5jPdLIY5m47GkINnQJ+hqo9AM8sCIGN9d/rXCkpMt6GQ0YBNUMAwCj
 UC6QLzS2uoTWy5pxkOghyeAP42/JhP8nwbv+aM0m1PZPgzFDHxGdwdqSfF8xAsZp/xAJ
 J+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790349158; x=1790953958;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iLbomf/LmyfGvEfBahUDa0GVf+bneOFHdvbTM8f8PtE=;
 b=uvHuGJ0nrlZAmYk90ocq3qS9ALgIZ2absqCOTCK6HFZbv2hc6rMOwsb+6DU1aBE8yx
 0fTDQ+Q9+EsNZDn+szAJk2fNoYtH0wTzSLY8jTVJUpMs2mXfAtYchoNTCuQtX/AhUDWb
 5tsjmKv7/EqulUEJNpdjNiwxpOt75HmjdKuhL8K1SCUyOhOAjxvLq4wV/0kQNbFTBF+g
 gczc4KBNAxRsg9LNoTF8EMNnIrf3NRP7OBczmgKq6Su74yVj1INg34WTVMGB2jswLPqA
 ehyYCFqqo/Tgqs4VF3WkHI9a2x3pqmr6X8/moAKuU5e7Y8uCAxkgKiWusirmWt/+gKjN
 RtiQ==
X-Gm-Message-State: AFuF++k2/qtF3pLNC/opqubQRjLt4mv3p1wKQbJ07xz2cYY0n+v8AXHy
 JzZlL+dewEBPdqMdHooFIjqp+ZuxZUK5SG6NAahkEXuvSzEpvAOvcB/a/EcT8CEQblJkFtAnbxF
 gyaRjYymm46whCXlmamwCrFMh7z087RbZRcli7dt62At9TI51qvYHz2omR/6YUIv9g65NxMFDOm
 J59pL4Zw==
X-Gm-Gg: AYBFou0fTLb3PDy4jcnv5VSw6LpuYSMO5bqZxbmsyVHGsseciCkZ6pUJgq6GkLh5Ww1
 y+HlwdQAaAM+85ByCPIA8zQiF/GcPjZsfSh5j/6WqShNhbg/8xtnpSSfHEh+bKWUwjDUABxs7IZ
 tEBJV7oKQEOgAfB7IVZY5uvbiTK5V78fr7zK7UeRJGtBSBUq511KAXfMt0Rf8Eqgl+k6inEx6O8
 lHskm/BURi3I3Rb+nl2vIgbFt3LuSJPx4SeoVv6iRfQ7RdH2pEMSZ+eGxa5qnjrxL8nNUuEDCw8
 tgPsOUikeVlQzU+ZprlPzZehrV7POh9j5+/ALBA5hGHBYhGOPbmUr7QDFIsmeAdEdrC2hgkgONd
 OX2FX4jLYTpCS4uKZ1Z3NREV5W8Jqau9tHWykYNmX+JAYzuoEA551KGi0pJfMWh6dwMGtoR7cpa
 epM5LTrtwpeDaw4lAmh3zn1xmwwMLVvgfpH3ct4i+8MsMW1K3aEbtzH0Yu6lbm22/BKxbOaBmbk
 znjMVT6P8ewhprnNKQni4IFAY+pgeR6CpK/985C6NvdiKJO4d2E0MLhZiiQG6jjuDyGmBrNYHAS
 h2vgxqaT9FhV0XJN9zdGZA/hyYNQoWoQbdVuWf9gFu+lkz1CqqVLPyHm8uY2
X-Received: by 2002:a05:600c:c177:b0:49c:fc6c:be19 with SMTP id
 5b1f17b1804b1-49fe67080b1mr114614975e9.31.1790349158034; 
 Fri, 25 Sep 2026 08:12:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a354d57sm7403323f8f.14.2026.09.25.08.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:12:37 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 15:12:36 +0000
To: MaxF <max@max-fillinger.net>, d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
X-Gerrit-Change-Number: 1907
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1907?usp=email>
X-Gerrit-Commit: a453210da741209545b1b6d026a6487151789341
In-Reply-To: <gerrit.1788885240000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
References: <gerrit.1788885240000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MjQwMDAwLkljOTgzYTNiZjFlZThkNGVmOThmMzg4M2Q1ZTVkZGYyMzQ2OTZhMTgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eb0e385d56b5af80e862efd9d472d4461538ada5-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA7bQ-0001Zt-Ok
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: openvpnserv:
 harden CheckConfigPath() a bit more
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, razvanc@mailbox.org,
 max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 plaisthos <arne-openvpn@rfc2549.org>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3885141281655101784=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3885141281655101784==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iTp476WdqJY="; charset=UTF-8

--iTp476WdqJY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has abandoned this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1907?usp=3Demail )

Change subject: openvpnserv: harden CheckConfigPath=
() a bit more
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Abandoned

the relevant check is already present in the 2=2E6 code base
=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1907?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: abandon
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: Ic983a3bf1ee8d4=
ef98f3883d5e5ddf234696a182
Gerrit-Change-Number: 1907
Gerrit-PatchSet: 3
Ge=
rrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: cron2 <gert@gre=
enie=2Emuc=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Review=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvan=
c@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--iTp476WdqJY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>aba=
ndoned</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1907?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap">Abandoned

the relevant check is already present in the 2=2E6 =
code base</div><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1907?usp=3Demail">change 1907</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1907?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: abandon </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E6 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf2=
34696a182 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1907 </=
div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"d=
isplay:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ed=
e&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@=
openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--iTp476WdqJY=--


--===============3885141281655101784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3885141281655101784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3885141281655101784==--

