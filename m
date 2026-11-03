Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E992606D837
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Wrm4Gi47;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DW7Y8fUp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EKJ5wXOM;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bqe+9msG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jCPsReF9fWsHDqbe/dNIzeMai8lpN3Sv/98DfrtDhhs=; b=Wrm4Gi47wrMv4YEUe5wBOLhfdh
	co4OCSRI77fqGuHfNVlZHDx9EylG0tG422FKizyPkNJz5S8cmWiKMBFvm073JpJCX9P7e2pwa5XrZ
	4EoOjFFiLDSAxh/SFar+EjbD7b4aqc/ZYRHJsvKItd/S8GW97kj+ZAwXGdgnx588wnKE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOBQI-0000000085C-3SxI;
	Tue, 03 Nov 2026 10:07:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOBQ3-0000000084D-3CE0
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:07:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Z9zfrrKpTJZQ05HNi8yKn3yU6MaQqTc/ez9tCIjIrs=; b=DW7Y8fUplK/QQEu9lZ/9xd5JgX
 jD/CSAewMKKrYiUQmnxziHP4iQMpr6geqymx92vuEey9lnYSKQJ7Bfvf6EeyPUsbDm53lApEooLc9
 P0GHhrqzGORV338CuINedGqswHxvH/UwSoxRIS5zT8xCOG8ve/TJ96ojrMxFcT6/u9Zk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Z9zfrrKpTJZQ05HNi8yKn3yU6MaQqTc/ez9tCIjIrs=; b=EKJ5wXOM6Mjb8dYFgnL1qw2wsS
 Eir5Ypc7yvRwduDGhJb76p5esV6HbVuxoNUDvA+ycQyhwYV4NtsyLD6356NECdaSr60Ljyc+87T46
 WM6aIpcxNNVgwLxIC94vOmONI4yLYzojr6HBEx4XYRELEedJtQ6uTfQ9x1BpxVogcDgo=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOBQ3-000000007Y7-0O9q for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:07:07 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so25473265e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 02:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793700420; x=1794305220; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3Z9zfrrKpTJZQ05HNi8yKn3yU6MaQqTc/ez9tCIjIrs=;
 b=bqe+9msGNwQuGsFxm3O1mBnxxZlVpf1pj0Y8yFVxBTbFIC9R3Sdb/5QHQ8zaL4mlLo
 Dg29RMNkpu7EMLUzaEVGZ0dnoYARckvb9f+dX4HLvTI3W0VLhDj4HfF2/JyByKQmarCT
 631cnC2IEXhNjo233mxwno10F6tfuGlMGW0MZxPTGRSckzlr0rXZdGGlSjrzKMDQFvFr
 HxwiiIMxOGXHcGVzKrTswHs+cMbktN2xHgXMtLMFTO7Rjq2/zYGI6wbUwAJ050FNKJdg
 hrqszbH+NgZS2EAzKW1LnjmndDwSDxm9PB57vhOFV9+A4xnVJbGeJNiFq50LovwZPMhZ
 PACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793700420; x=1794305220;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3Z9zfrrKpTJZQ05HNi8yKn3yU6MaQqTc/ez9tCIjIrs=;
 b=v5iJ7WGSjLojj9K30yMh1JfNByrTUjX5DsKC2Qdsa/EOtbd9K5tSvnTq79jJ6cgx8n
 Kzsbc+wOD9IyCav/Z94J2OLjZOVAaXfBySUCYVdIhrmVGuPuxHITFQzT+qaWvix1h0f/
 xOgVDRxJQYw88OeM67gKGnMjz+z6E3N9AGqZ7L55UOfGwH5Tx6jGf4H1nDmJvhN+s2mg
 i2HoI+pgIEAtrxeX+KHCTklXszI3lICGREIESAiQNUdr1hBPHCiEzsAHb8xaGaoS05o5
 NNwnjgS3HremD3hu3UaTHpnQrgcJerQLxqgVh3Y8pChG7nzxt5RneoXkImCiuQpINctO
 22pg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuXf22Z2aTc+TkxM6S3RHDRkRaQSd2Jt0NkEMk/shCIyypwXSfvRAYTxqFgBFsFprsgfPaaLUvVnwH6Zn/@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8AvVirHtXyI8PeZf+4D99ibUlzrCTM6s7gfdHLX6A9AYhBnXGk
 CisvBd0hRbCUKxKr6tog4jlWS3VCachqpFPTunPgWRaFPz363vdFXgzMLmsPMIUKcyeKENcosgj
 wntsixjJLyO5ut6AxdKfgo8EKljIqNQ6wPsiQ3rc+azBwsCYOYsq4dUIWE+2CwBAY0yj8dvxFmJ
 WLJs/2JA==
X-Gm-Gg: AYBFou0OewAaVcRwEupwPQKcWbSNP5eU2gK9PSsHRcvIcL34JWzL2yPFWdPIvhMh7pt
 x+7SgjDEEUNSaUiZiGpsivQ/Jb6d/iAwJ6zaN3CpHTCx8Uabm7dmYqTjTrWBGGtpaEVN2vvWzcy
 TvwxxLe0MxneBzotMogVFtBmpDg+4mXftXYCw13/ROS0+JF/jIYNuoTOlDy6l8e/tByG0rBwiNY
 fPYTGj/hs7mjL+zwp7+sT9Hanpp5f5ioVVH3+ropvaf3l5O4FRDlw26RZg9Z8sj/QDusVnpcjEu
 P6GXdSqs593v8uK9k/c/AVUfLC1vKYjGnRKAsNTOVLm8hyVEoHo1v6twS87w/ZRfxBINjiB1PNd
 cZsVmlW0NePXuY31V78xCmwzALiiPSuZAUmNQcZTpNh38OlkV2lh4yIERoXIvLiF1WU7S8/ouat
 e9x/iyofwMdN1VMdN7UUpJdhNSGZRipRYtpxzc15uLz/dtDU5CTmlFDIjarFH0q2f3sG/ZJtM2+
 9NDuA1UPxxwfkNUg9g6bUrzoOKOxwaaURUk9BehXYdH/pqmAp8ZoPuDGmqVgBpUnYh8snYNW+ZO
 EoxNcO5yAYHP26JkI6cSOuco+u1fDeWIEqRBD0qtcaIBtlT1c3xDq8GirlA7yA/+tXvIHgvCpWq
 /xQoJ9+DbiadkGd5YwP7c89O3VVSTzCPlrlegLMTNKZr6R0Xnf8LucIjApxRpeqDd+PyjUMrnDq
 LSkRyxX84WjHsQCg==
X-Received: by 2002:a05:600c:871a:b0:4a7:d9b1:b684 with SMTP id
 5b1f17b1804b1-4ac14ec7947mr290858925e9.2.1793700420318; 
 Tue, 03 Nov 2026 02:07:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b393fd1748sm2947125e9.7.2026.11.03.02.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 02:06:59 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 10:06:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
X-Gerrit-Change-Number: 2046
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2046?usp=email>
X-Gerrit-Commit: be5e142bdaa1060f0fe42dc8f882a913d8a4e378
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 10:06:57 +0000
In-Reply-To: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLklhN2EzMWZmMWMzNzkyMTA0MTAxY2IyZTgyOGJlM2I3ZmQ4ZjQ0MTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <39bdc5c5e4a3b71aa01fece0f899b9cf40597332-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOBQ3-000000007Y7-0O9q
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: dispatch
 UDP events through TA_SOCKET_READ/TA_SOCKET_WRITE
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6403864121841324493=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6403864121841324493==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nno6zS37u5o="; charset=UTF-8

--nno6zS37u5o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gianmarco De Gregori has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail )

=
Change subject: multi_io: dispatch UDP events through TA_SOCKET_READ/TA_SOC=
KET_WRITE
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 2:

(1 comment)

File src/openvpn/multi_io=2Ec:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2046/comment/82b89a2f_7d0af0f3?usp=3Demail :
P=
S2, Line 689:         while (!IS_SIG(&m->top) && (mi =3D multi_get_queue(m-=
>mbuf)) !=3D NULL)
> Before the patch, `multi_get_queue()` ran in `multi_io=
_write_link_pre()` only when `m->pending` was  [=E2=80=A6]
Well in the fina=
l series it can't: m->pending is gone, so the
packet extracted by the drain=
 is always the one written next=2E In this
patch it could, but only if m->p=
ending still holds output at the drain,
which only multi_process_file_close=
d() can leave behind, we probably might want to get that one in first?



-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia7a31ff1c379210410=
1cb2e828be3b7fd8f44156
Gerrit-Change-Number: 2046
Gerrit-PatchSet: 2
Gerrit=
-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Tue, 03 Nov 2026 10:06:57 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>

--nno6zS37u5o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gianmar=
co De Gregori has posted comments on this change by Gianmarco De Gregori=2E=
</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Dema=
il">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi_io=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046/comment/82b89a2f_7d0af0f3?usp=3Dem=
ail">Patch Set #2, Line 689:</a> <code style=3D"font-family:monospace,monos=
pace">        while (!IS_SIG(&amp;m-&gt;top) &amp;&amp; (mi =3D multi_get_q=
ueue(m-&gt;mbuf)) !=3D NULL)</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Before the patch, `multi=
_get_queue()` ran in `multi_io_write_link_pre()` only when `m-&gt;pending` =
was  [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Well in the final series it can&#39;t: m-=
&gt;pending is gone, so the<br>packet extracted by the drain is always the =
one written next=2E In this<br>patch it could, but only if m-&gt;pending st=
ill holds output at the drain,<br>which only multi_process_file_closed() ca=
n leave behind, we probably might want to get that one in first?</p></li></=
ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2046?usp=3Demail">change 2046</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2046?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44=
156 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2046 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 10=
:06:57 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>

</body></html>
--nno6zS37u5o=--


--===============6403864121841324493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6403864121841324493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6403864121841324493==--

