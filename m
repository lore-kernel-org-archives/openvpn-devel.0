Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BAB606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=atCrQfyr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=h7MiujvZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IiehOjyo;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bgQZNe19
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3JrBKWn4GSy4nHc06x1gJm2ZVDGk1joN3L1X4Kupcfc=; b=atCrQfyrJVW3xK0DeyQjxwmlEZ
	NosWQtl0FS23jcRPjAx76zmCY8dClqNEGv5ZlAy0Doi2HOGzrTutQVs4F8gslcST2BPvZdpNb2vA/
	OusgBjIK8jIZ5eetYKej58Gz/rcgCwYZJsOZaR+pN6Vg2pAhOvPKNJ2kdvDohxPrKXeE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPJOe-000000005iA-2yOY;
	Fri, 06 Nov 2026 12:50:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPJOd-000000005i1-39QT
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 12:50:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dfDZdX82CYdPzpdYluPpbxC3TETROXnHqzL3pLHXSCs=; b=h7MiujvZWAhnwpt+QMhV1Savsa
 CgPH0ieLZ7G4wO1uGV1Gu5Gk2uFHU49+j9HOKDq0G9zwxGFZfvjT38W7PPQEsTEkKuxxhogy8UzLp
 t6QByeCklShYmX86na2aEPFGElPR9CY9PDzYJeppUuloqBzjUg6QtwAljhAf+rYg6gzA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dfDZdX82CYdPzpdYluPpbxC3TETROXnHqzL3pLHXSCs=; b=IiehOjyoolW2HFiiZbTyXEeTGx
 osN6WLEOi+m2JxogdUkwNHkDjUie1BixDLwuYEMP5I4hyhIHFNIyEbhYxZCqHOAvHCOZOQ0Gvu3Yb
 zhNSRcXRpdXyqg4qE+aAhor40kKJd+Z/a1oZ3MFSxJMoSFLyNUEAXFzYv/oF7Y3Vdos8=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPJOc-000000002T4-0pL1 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 12:50:19 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4918c2d727fso334963f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 04:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793969412; x=1794574212; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dfDZdX82CYdPzpdYluPpbxC3TETROXnHqzL3pLHXSCs=;
 b=bgQZNe19NYg0xYkWuYU5ylONhfH8A3oXyj/7FMz3x5VyLOh9cGcxfoOtnYzRAndzVm
 ls26iwnMHTTCuDE/N+V/nErTz2HHhVjldgtWM9nsCaoABwnYu8HQHwZ0lc6p1GqYRM2G
 vQ9yzF4XGqaXTpTtdcuygtEN7j4Njd6IZekTN3eFlAw3Y/o3c2JF1nb85ooWqwDx8eAx
 E8x6iGs6P7nSEUaeAOD8zXi8WaDKZiFH0toNzhi2RYwNF7K3Mf3OX2WuSCgECjDQUSNK
 GJDvckCu5KyfxyyLOMu4pdkHoV6BCUakvu8aU/05J3LfR0ad3+YYvwYrqeHJ95WjsNbu
 PZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793969412; x=1794574212;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dfDZdX82CYdPzpdYluPpbxC3TETROXnHqzL3pLHXSCs=;
 b=0gLcc0EjUVDqBSCOIa2yn4o4i/39ofyzWFEvk3RjrH9nB5NegM1SENAe4LDNG+W0cq
 eorO30gGd4UlSbDCvnjMm29o+VvNWiMGWOjLRzOQFI6VTjqsLb8FM+H0bRu8gNCzhm0A
 J6Bluuz5RckaT89mB+37NYnL/lai3/iSLQ37d8mlJieL5jkXhoZLh2RkI5o/Bcz1dRLp
 Y69v+5nCtpWnOr+vJ0YZM2Mykczp1dtK6HjN5NXC46MGaPVeNCJqlK1/zEitPltK34sW
 qvtZS3buQaJ3HbKXTS0mBcjqDM/SgS+HoCeeQYyX8vazLlZub+IQAzLBoexV++qGSxFu
 veDA==
X-Forwarded-Encrypted: i=1;
 AL+hErGDsR7Vdxn4gJlwF8myRjhmmJdIudNhcSK8EdaOru34dP7+gzr+4RAbx1IGC3bh1XQJ4wssjV2OnisRpR2h@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8d8IvlX8dn/ui8FMvADD+n2hVFX0h3Fi9QSZnE5uBskJCy/6r6
 gHGDklPj+3kJ3/00jnV99/Rtn0kCTLb3Kk//RoBiEPVnPd842NA5jmkWEzb0oI7BspfGjjwenm4
 5ievcMjsMO0p8vkuHE+NuYwSFhCTVcEbX6j5eJpUrueydsUOpjkVE5yUIuZAXlFH02oda
X-Gm-Gg: AYBFou3CP50zk4HJuA5EtYsqLUoiPxZu0KE3wknGgZ4n6qY1Io+yahHcfIpkSQkdxN8
 5Vn9J2hLUO0Nh6igWaZ2/LTI66Fl8ggHObaG6B3Hxr7oHMODO3xZd9wfJA1agGcbahWcWd5XgA6
 5tj8Vd/a7T0ULxGm57KeGHrYDqujOzcE4ncNnLz1cuOvxRHv97n/tb0Mq1wTdF59GNhGWxzci11
 ymg3ZBs5js1ITd2F7AHoet3+1kAFyWtKq6bbH2oDOH2ds8biXjVvWZC7xcDWS9nWWExeVt9P1Xz
 88/MFNzOBT19DZtXddOy0zwS+2aCB/AWtOrrgGvEQmmOwr1rpejL3e82ogmF6+4sXDCpiTtIZK2
 AJg17YQnna92DfiEpII8H4gogD1C6Dzm02aVmirmVrwaQnLnnAYGj+LY4b6zfdiRtFml7l7DTdM
 ci8glYUO4eY/e+65WOwaBG9S3pBKE37s1BdM9oC+DBdWQftocKDvPHEN/DsbGRbDiQtcVxfRGGx
 a/Upz12IKhBVGqexY3CZmE75kRRauCjQyueuFMFy2Zpcs2hoPiDzhdqXcgXQ1lBgZ+62lUIAKuH
 2u/wHk491Q5eOtmSSqwWXs3rOR5rvF68HmbwbCp8eTS5GXFD/VX6HR5j5RnUAr2oQRXmjL0OmF4
 RPyCp0ymR5GbMDD+gTw7LA76cPzp+IsfHW9TC7VQPoB/d188XO7QOe7aVMqI4R6+LuoW5d7qED/
 L3jcpXDxW+QQjaMg==
X-Received: by 2002:a5d:5d12:0:b0:48e:1b11:7ed0 with SMTP id
 ffacd0b85a97d-49275a26772mr5672309f8f.33.1793969411402; 
 Fri, 06 Nov 2026 04:50:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7233297sm3708436f8f.27.2026.11.06.04.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 04:50:10 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 12:50:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 960b56641b7814262f6a811e7f4338d4224bb741
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 12:50:09 +0000
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c434519a117bfd6553bb3c878202ed37951ced7c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xPJOc-000000002T4-0pL1
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Adjust
 ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5627952910556605254=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5627952910556605254==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="scQxj94ayGY="; charset=UTF-8

--scQxj94ayGY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail )

Change subj=
ect: Adjust ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:=


(1 comment)

Patchset:

PS5: 
> Unit test fails: [=E2=80=A6]
Done



-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a268fc602e916bf54853c9=
50761977cf3d7f835
Gerrit-Change-Number: 2130
Gerrit-PatchSet: 5
Gerrit-Owne=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-=
Date: Fri, 06 Nov 2026 12:50:09 +0000
Gerrit-HasComments: Yes
Gerrit-Has-La=
bels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--scQxj94ayGY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">View Ch=
ange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2130?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Unit test fails: [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130=
?usp=3Demail">change 2130</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2130?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2130 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Co=
jocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Fri, 06 Nov 2026 12:50:09 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Co=
mment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>

</body></html>
--scQxj94ayGY=--


--===============5627952910556605254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5627952910556605254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5627952910556605254==--

