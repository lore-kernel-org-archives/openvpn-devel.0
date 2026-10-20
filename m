Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A95606A319
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y9MVYGaJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MXjtmw6F;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eZKLeP9X;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OEMipS8I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JIf1JSVk99/W+PA3naz9LSsDgnTNjhULkhJ3FCx52lM=; b=Y9MVYGaJU12K1PufwR5zZVWfFu
	58/txkqUSmRG1wfu2FOQ9i1/xfl4dEY1Ga4+TWSkl4Fo3Knu0opcbmhOERzEf60ClhmbwKihRsd6e
	XS9GaIK0oj96MiqaV70jA8D1XV8dB0Kt+JxiiGjmEK8uQ+5af5jP6Bnoqax7PELYz8YE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJ9Qw-0007tS-49;
	Tue, 20 Oct 2026 12:59:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJ9Qu-0007tJ-IT
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 12:59:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=86lXsDN2FeUrZ8mDV0exL2zJcxpRDQi0m4XE0pQXJ/A=; b=MXjtmw6Fncapy2iWiOwl0HcF3c
 TIkD0iu14n16LCc+c+noQwrgAlfWIEmZpUg/ojPRr2/fBvZ2CKPtgBqyafYnyMMckl7FA2L8/7ycX
 Xr4dhVGAYkBqwjhcyg5pZ8V6E3akTVdjimNxYhDleAiH+bGcY9YLObsFwSsDJyHAWV8A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=86lXsDN2FeUrZ8mDV0exL2zJcxpRDQi0m4XE0pQXJ/A=; b=e
 ZKLeP9XbVSo6dy0GZx+hGR0zWRBh+UW3C5xd9L+7EoYg6bpA5u9sFQ646sl8ztzQLXSdyiRS+tn5h
 gbFYdKzaS5gq7Ky/zxKFw4kEnqHFpLUBs9IV66Sjp9vqz39nIWvSbo0EwoXKGL8JiOFPA0n7Iee5M
 YJMOh3DorBypqIBk=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJ9Qs-0001AG-MA for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 12:59:13 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a1cef0439aso35387715e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792501144; x=1793105944; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=86lXsDN2FeUrZ8mDV0exL2zJcxpRDQi0m4XE0pQXJ/A=;
 b=OEMipS8IN+Rr5hwMaj5ZVBGh3QEW9W0FYHjO7ntIf53A57GZr2AzqKVDdhSUSARU9w
 6lL64Q7PGhmnv2doum7RUEoF7iilPML5E0zRfHZmPGfJzP9zEvNK90ZogJiX+GihzuJq
 aBpG6KfM/SILJIzArAn3hjU8YrXHwV7OsA/IB7AHZeKH0f6EqKvVI4ual1M847DhP7W2
 4tNMbImSseJDQW2SxSJi5tkqz1f3qtpwvZj9uJNOb/zFHKUttvMFEPGwc6b+qoKZbeSa
 ckioYQ6laOpHhs1dn8gxxpI1JzEYDvLae29A4hck26JAytE5DtswfXzC5r5gqknFE9ED
 Rczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792501144; x=1793105944;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=86lXsDN2FeUrZ8mDV0exL2zJcxpRDQi0m4XE0pQXJ/A=;
 b=jinZ0TJtmyRqRg80V74Gh7U/pcEUv6U+uK04/sPnT3hnlwpUE9la+9LqCvtOWxPiu2
 ztximvohcspeRNLvVJC0fcDaO2v4HfN2qfKvcPkvxFcIFbtWnRFOCjyWfZl09ikxafcu
 mAouWl3+r8zfPfswujPmg9dbOHdCh5nTVZyFW+brjISnWWAr56NVEZiDFnvNSQaSYyqO
 yMXCgQ9Qu2QdN/a33bG1z7F11c1IEyNESToE3JxPXEiE94fziGRUqNloQLCqZtbWsm/R
 qqYCe6E3N+b2M4+LWdlKgOt9ONjvQ9Z2FEkIRU5dFnUZUcLDeEhJKQc9fdKFaSxH5TyP
 mwyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBym9I8IZ6JZvpzhjtVdNyJEhPgazJxAD2TRYVvLMhP9VapSmaNer1C+FtSflvbmrTWJPFZEykgb9/pJfg0J@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIYiy2MWtg4jlq7sq65dmlhPRXPD+sHqkJJH2dlqjQNuvTh066E
 ijsuRgfAPR0tStIYTqGFYHa3IPgkUCdjc665pd3jG39WpUuCIfUhQJBwDKR9i7RUE96dfK6TsCx
 6qvurRwwYeZPQISQFDrAqdUGRlUWHqqI/X1mKa0Uu3c6Ih1vTw4ucrmuXKwhd+6V+NguQ
X-Gm-Gg: AYBFou0neXw6gWmblFV2QTybPVYVocxpgtIyOw7/X6os4N01ZqkEVCvJBRPQNSQOceY
 Vz4McIUP3tFmJDV4CctRrs5kZFiIDRr1XwKgonFaxmQv/J4bkAadtfVLHBiQwhUsHs5nguYRdra
 uOCy5Oafww6Ejb4Vm6aeA8RZ8Vs+HBghGUmJz6JDzuX5GAFq10LDegMalT76cCGKai+WBljtXCD
 X5GdyNswwWn9dl91RGiNd0Uy9Wc7MhGrkzxOwTroFTIsPnOdDQM1bi0RcY/8OAlgV6ivss8D0tj
 Mvh+EV6E3CTHi6HgbENI9XMqAk80plqfLLO9fG5kX5t3S6SmticGs5o8M0fyUJm2nWWQTdLFQ8p
 rWRcLFYHxGAJFYdzHlKb/IUSoCpXfae8e7aJUQouX5dzTZMI3ZYY6WvPTxc/5eTzLWuEuiAKQK5
 s4CyOwjN7EVda2h8JHxSyCuL/2/LRnGjE5Q2RRI6C++p3eZskNykRSEQAY0t4rtmidq44VNgyNn
 4qfQhvJ5yD7HCT+kT78ht+am7p0yKwrrQ3ypRYyYrqglvGoM5ft2gkjraOO7qohQjRukuX4Cc82
 isSTfwFgoao+pEXzeZpr90MBmQV7TGI1Gl6Beq/N/Pg/PTHZ6b1Jg2ZT7DZz
X-Received: by 2002:a05:600c:a10b:b0:4a0:263c:704f with SMTP id
 5b1f17b1804b1-4a1d7601226mr166354615e9.16.1792501143613; 
 Tue, 20 Oct 2026 05:59:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d80fb69sm5485711f8f.18.2026.10.20.05.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 05:59:03 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 12:59:01 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I149d0ba7011e62a115a565813e1f5873907d464e
X-Gerrit-Change-Number: 2022
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2022?usp=email>
X-Gerrit-Commit: f4be7bd1c98b877906c23543390235790fbe826b
X-Gerrit-Comment-Date: Tue, 20 Oct 2026 12:59:01 +0000
In-Reply-To: <gerrit.1792405183000.I149d0ba7011e62a115a565813e1f5873907d464e@gerrit.openvpn.net>
References: <gerrit.1792405183000.I149d0ba7011e62a115a565813e1f5873907d464e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNDA1MTgzMDAwLkkxNDlkMGJhNzAxMWU2MmExMTVhNTY1ODEzZTFmNTg3MzkwN2Q0NjRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <df7a5237a5edd6d0c581b35787df1b9c07197fe9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJ9Qs-0001AG-MA
Subject: [Openvpn-devel] [S] Change in openvpn[master]: automake: Add
 build-tests recursive target
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8962590375591718036=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8962590375591718036==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kD5TtwUmNQk="; charset=UTF-8

--kD5TtwUmNQk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2022?usp=3Demail )

Change=
 subject: automake: Add build-tests recursive target
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2022?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I149d0ba7011e62a115a5658=
13e1f5873907d464e
Gerrit-Change-Number: 2022
Gerrit-PatchSet: 2
Gerrit-Owne=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Tue, 20 Oct 2026 12:59:01 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--kD5TtwUmNQk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2022?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2022?usp=
=3Demail">change 2022</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2022?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I149d0ba7011e62a115a565813e1f5873907d464e </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2022 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Tue, 20 Oct 2026 12:59:01 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--kD5TtwUmNQk=--


--===============8962590375591718036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8962590375591718036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8962590375591718036==--

