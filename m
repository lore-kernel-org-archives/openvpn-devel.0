Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D851D606B78C
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UaLA6U1L;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IgLWuWo5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kr2Ru6nV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RuTXclmw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qpVRP8Bs6bABBtd7awJXWlzsaVTo3YnGRz+ak1BXP0o=; b=UaLA6U1LoB5i62y2oo3hayBEfD
	kH3xbWOs3NHn9s+D44Pk/kJc943Wnfn/VhreKewOHjmzeXPA6LMWqb+rsvzo/dAgY477q39x/UGGn
	uMOgr2cjTFC5Kqq9iQRGiiIPW6/Bo0B9DoRhSf0d85lTg1gISc2/O6J7waDAblqgY/pw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLelV-000000004QC-1wjR;
	Tue, 27 Oct 2026 10:50:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLelU-000000004Pz-1CwC
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RSECXVT3rQiqeVcsiiwM9p+A4yadgnN4G5CZsA++sHw=; b=IgLWuWo5qn2UiHZ+sOS02w3ww/
 5/+pfhRTqvyXOV/F/BUp4nYYnXW9ebI+tIlbqMvFWnBOz2aZ9+ew+x4C/wFrfuE4oRvzEodL4KPLc
 g8eqXxPlzlVRIgqURTTTvI/n84jLqpTFJm4Ty6IIjreVUeG2EvBlvthyhbV4AaoMloVw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RSECXVT3rQiqeVcsiiwM9p+A4yadgnN4G5CZsA++sHw=; b=kr2Ru6nVnwbkPBedyRKU/rTxFC
 He80N40BYUI/adQ7S57GK1iZcUagrP4n7ztPz+cqJZv4M2UHs7wUlJSSHAKYOL3qjAweuNRQRWgy+
 e7+IH5Hh+3BsG30KHQJCR1Mhxrp8d/t2BLMIqvxr84iVpewtTtr7WIgZz+umMWHC9kow=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLelS-000000002mc-3b9D for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:50:48 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso21635025e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 03:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793098240; x=1793703040; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RSECXVT3rQiqeVcsiiwM9p+A4yadgnN4G5CZsA++sHw=;
 b=RuTXclmwCPVHjCJldHHhIewHgceQIF18Sw/SitE/FTszPc+ZrlqMw+fmeO0ViKgx+U
 jN9oVW5yT9Ru4/qwKAM47Xe8p8YCbmuRd7wDF1PRBHvS2LujItypaUmyfSYQmx9mzvNw
 EQw5nonqFA8qo2RPR/Pzuv0a6DkjLZ+fvqvtajdLqOUs6/zP17MqmOzjPgaRrzmFrGZa
 GV0kegfsFWYhZnvQfAfGDoEa+nzkhyLCCWAV+N8w1LwADUfGVgbklnTdO8pEdvJVNbvK
 hs/BLP0ftkI6YU41veEhr4+hH8oeMH6FS1Ttg2kg7l22wUdLsQDK54TsolZmO7JH3VLm
 pvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793098240; x=1793703040;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RSECXVT3rQiqeVcsiiwM9p+A4yadgnN4G5CZsA++sHw=;
 b=1PxtSEzkLZYgGui5+tL6vAvXNgjd+KvzJUqBK2se59s/SaPfCx94V1cnsy8KtCzm9J
 p1QV2S4km8ia5f1fugpWj8+PeSOmitIbdfYCv9gFpw8Stdz3bxIRwdd3yiNCmXiR8MAk
 5VTXJjhsQ3XohT044DYzQeh8HtfbPCKd6TvFKoV5JxPb4w+LlP6FRqbeOEPXELm9WIzo
 Fc3K7uMgw+RUtYT67EPlfyRMMHXglF6jFhJ811C4nLD9MxOE/oY9bmMDhacOTBg77MC/
 RG3ByuAzqKNZaLuf7/fv61v7I9hmxd490a96BxDD7GXWpGMpb7Lm/Lo8yvV5uTpg3wWL
 6S+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6QWS7+cmUnBa9Of/1nLX3QTRbED6CZrDxOCz6ZoQbVR10EMJjDTjOBwNgWhpNGbNVbMAuvwubfHi0nMm/@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJU5O3nJeIelONzfj0WvRKE8YbxrLrym8lyUR/uiVfg9MHfN8rK
 KrLYROvP5T8r/nGtrPNQIz1KI1GEnN9hNuqZDM/NF5KmujnHUMgKS0gin2+7HPk8NUUxAU0JxiT
 eghuQLTa0fiICDi7u816AiAt1IfDfoKZ7ZHt7mDcG1TChcoijCo+kiaMwRIBy8e+HEYQK
X-Gm-Gg: AYBFou3+TZMyBpQXQUxQT9s9eXl0e9llUcfLQAE1jKBxSUiyekGrklFOXvRYW5VF9nb
 BUdMqF5yALonOB59Tep7y95Dx3ujMtWm6ivE5aRw0QFxa841g1gZ2wbGKXgjSjBvxizUSwm7sIB
 zTLTiHaRp7WhyZpm+/vZN0Nln/reQtG6E67Jxk1FKjJ/AEsvb/qjLINVO1l62KAU+LXy8AMbf6e
 yBvREEoo3Kckzftl98pNhBwcfi8E36UJ1dLYNH0bCLxWLFkA6mvwP+7FNCoZxCY5bgn7zjaD1Gn
 welBZlOHT08DP51GPnDkbH+QcA/iewPQ6sVyUHR2H5dy1Nc+9SI7hysWww+RyIY7NUO5TYVp98g
 TKJcc8Z4jpHZ9qdvFYHjhj76Cs+H8weaWYCbo9fu8HLN78haOwN/khK9KHaF1m3jjPeAjMNdzhH
 DuCq9brfNYDRGuDWJ0L+5RUOCHTbA1lYBBefs5V8ZqWR09KiKCt6IjcFP2SSRphILmS2JvSiivO
 Z7RgNM+gjUgq2Jj+kSkjia5KzDpQo0HR9zQxuUK9dp+c8M+GIy/OnZQ/Srqs1C8w0bSgVypUXas
 4yWpkiWOY5DvuUK8lammkYqevXX61xEwJGy/V4mOgc/p2o0rfvYhBH6sTw45jJxltLSpBqrA5cX
 B2rC7nyIszIF4mBgDAxuUcaukaDvV38xrmAasiXPNLQ==
X-Received: by 2002:a05:600c:1388:b0:4a7:6425:c274 with SMTP id
 5b1f17b1804b1-4a76425c27dmr75332505e9.2.1793098240105; 
 Tue, 27 Oct 2026 03:50:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ad39sm672321535e9.1.2026.10.27.03.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 03:50:39 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 10:50:37 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iac629903f49ad9e0e1d1891acf35e2000f31f5de
X-Gerrit-Change-Number: 2043
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2043?usp=email>
X-Gerrit-Commit: 557539c473eed85da762d2ee6d22a5aadb0ff15d
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 10:50:37 +0000
In-Reply-To: <gerrit.1793094393000.Iac629903f49ad9e0e1d1891acf35e2000f31f5de@gerrit.openvpn.net>
References: <gerrit.1793094393000.Iac629903f49ad9e0e1d1891acf35e2000f31f5de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLklhYzYyOTkwM2Y0OWFkOWUwZTFkMTg5MWFjZjM1ZTIwMDBmMzFmNWRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ebaf9013f00afa1acef30b09c4eca65c914450d3-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLelS-000000002mc-3b9D
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: move the
 link write functions to multi_io.c
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
Content-Type: multipart/mixed; boundary="===============1188636494270525950=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1188636494270525950==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RoQ7wFIDvZE="; charset=UTF-8

--RoQ7wFIDvZE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2043?usp=3Demail )

=
Change subject: multi_io: move the link write functions to multi_io=2Ec
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2043?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iac629=
903f49ad9e0e1d1891acf35e2000f31f5de
Gerrit-Change-Number: 2043
Gerrit-Patch=
Set: 1
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
Gerrit-Comment-Date: Tue, 27 Oct 2026 10:50:37 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--RoQ7wFIDvZE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2043?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2043?usp=3Demail">change 2043</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2043?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Iac629903f49ad9e0e1d1891acf35e2000f31f5de </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2043 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 27 Oct 2026 10:5=
0:37 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--RoQ7wFIDvZE=--


--===============1188636494270525950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1188636494270525950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1188636494270525950==--

