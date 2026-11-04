Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23521608362A
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VLIG1Q9e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=P4wOWFwN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KFU2TdU6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KB3Fs0Ue
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3k3RCaEkPxVhE4tPuMHZk9BbnITMMzc8F+HLFIYombI=; b=VLIG1Q9erNDEXzxsuAvy07G0jC
	oEidjReVyq4m1i0KUp5NP5A+Iov2lueoAlQtmhDU65PFg0YWEYBVZvWc6pOMB6puoFgUMB2q7hV0s
	Ix8hXnMUxDCbu8DFZta42m08IyVfS35opOJfpHBtZCoF3xjZhxunQFAmBEuOhqVJEhgY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOdMd-000000005tj-1pf1;
	Wed, 04 Nov 2026 15:57:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOdMc-000000005td-468F
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:57:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sIfxggn2rILACEBpnLkKG3uYCqvO2Ph/0S/mTeyrNAw=; b=P4wOWFwNaMuWJZ/gtZeFh4KciD
 HylbcImAF4w/UP5fEJoXyg+et2bGh1fHE/ccH+NZTPlr3hrTvYy6gOXl4gDQpRZc3fTocVAmPm6cW
 6iB/fUND71DI70ltHlL40UJ7wWKeUltgTQNmr8YM45NHT1F+H0cNMERJPfqJq9p4f+5I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sIfxggn2rILACEBpnLkKG3uYCqvO2Ph/0S/mTeyrNAw=; b=KFU2TdU6LP3bo8i+kupaHEgc8s
 NNTzsj7Qo5d0/aStZ5MnfJAVVxwn7ng6akFO5hiKNw5cbUA7z00+Nlj1EKhPQ+YF/MapdNxlCO+H9
 sSxufmf0MSia2cp+bnFmYcV/0kTEixC52v8fMzUIV2j6JSMBfx//s+JOsxonHr/HIo14=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOdMb-000000005Lm-0VAk for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:57:26 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso7997735e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 07:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793807838; x=1794412638; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sIfxggn2rILACEBpnLkKG3uYCqvO2Ph/0S/mTeyrNAw=;
 b=KB3Fs0UeLCv19D/rqSBQBxGp0fZ5KQYysq/V6gUYaDyOJUp2XHK7HQn4vCrtfnzAvK
 YpyvMS7mSPD6Le+kg4jUpPkVUogvWdtN+NJ4KLIZ7T9ZnQsNDGMKhfMRlrnTo9RPyeDJ
 oQbnUbOXtMN0fHtP0oVLXb2oh49+85agMwGU7peTIFTcAQE+wJsVt9xwK8lYw1zSQbi+
 UeeLs3c29xlShw5mQ5sGL4G0oEIaYZBV/SsO6xJEe9vtBx9DeXm5gAoKfI7or8VrjPDS
 gkE869xLMS8l6UwOIwMs/1IbRBkebDaf7oC19p0X9mmamm+1q5etZQKSnx+SX6AoMkM0
 DW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793807838; x=1794412638;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sIfxggn2rILACEBpnLkKG3uYCqvO2Ph/0S/mTeyrNAw=;
 b=qhIYNoV/sA1OfT4JxXBOG9KDd21szTtVyqs4hPgkrRTjrfvXyysFm/boKZQudTBcCV
 CtQ9A1xn2N6WYAimor5CC8NjZOP5O2+guWZJzwGZutJM08yCUoOYFHycafK72mxwAgvC
 dmtEGW/VmI47IxhwErUNabuDDIki+F0lDA/PZJyTLP44BPIqQBZO7tzoPfrV6Hw/Pdcd
 UFOmVTeovfGTgNzJ+J3bHPKpUze0OCs4Kouiocz3wDwpks+M++e2sk+t9xhsjaEVMN83
 2ZisGkCjehvayh2F7pm6/t2Nbs8oYJDmFB9tSXyJwTEOSPiAXFmMznzqCR9j8yVHfCQP
 cUdg==
X-Forwarded-Encrypted: i=1;
 AKwUvByaxZVVVGcBe87LcFKc7hJqUzCcm6x0QwF7MpyeeEviVlhZThrLZdNHWi2459sr9ZERLHb3sZNvvEdkrZnl@lists.sourceforge.net
X-Gm-Message-State: APuU4Z99k1hpnIoEY/3IKl+qLsKceJRt1DAdD3J6TkjApKV+qT4GZF10
 KBfERTUB+wmcggaPuHrHNRnwqIzdb5QfbNjtffYw+Dcump9oFR7rN3OoTrJwDlZ4Mhh5MZMLFHY
 lMrO9WA0XWjkJcj8nA7Us02c1p4AWk7NIu3AgYRbsNqefrRYQoZj4f9yljCfp3x2Jp/7Z
X-Gm-Gg: AYBFou0t0TfhO5jD+B8a8W017kzqtw7kuIp+QxJKnaRLWdHf3bWpngJ8RDe8LU61hu0
 8ghbpGF5zKuszks5L8/PBAvMGe0dkIrqGHr1sD66TXZEEDpLPxNB47VkSDd1bG8eJ77Pjt6CIUy
 SY21J3g5MmA8OYauVXyQH9GObdpe8BVKoTriwbivtMrxvAjB7bTM0EOAoYqYATkeCyumv5m3LM5
 OboBSAe0BrCR5GSwMBrXGhNt2NJfXdj3ceYUPOI+fl/cmt/A7OhRS+E4PZ8wAVER8H6az1JUP+Q
 KbHHzBtDYcEQHaG0nF5SKzwxIrTypC2/EpTDjrYBd3b+Qza5rkHnpdYwNS/W+x+1C8XwJVcCcT0
 1mZ54g5BrnKwCPIH2cxarcsu8CddjbtCHaX8ExGWBuulCZS0BZ+WbKpppgWWZLFSJqpE1CS9QV8
 oRbyubLnANHMckhFmc8b0z2XQfC0S9hWqzCVycZRj76QnrHawR6czEKRFbU0x+7YxIOE4OYlFjg
 h0tO7n58ZTXrA0h8a6pyY2UIBeOVzcO0f524LWuqs8GQyALzQ77J500SKUrxlcFtJj00KwEg5ht
 DBFDHNjUdi96++ZPptcv+RdMub/fnNeNM1hOnL72DtJB1qjWcTLiOylx8fXVJRek/aGZrJmCUap
 OMuy2jJv5s68V7+WPtxqga5kRbuKuE+E2zPI9EFxXgJh5GnFVQ/e6OWb1blTAbYslrFtw/YWDcL
 7T3untrlHY2MGBIRM=
X-Received: by 2002:a05:600c:848c:b0:4a1:f99e:f22d with SMTP id
 5b1f17b1804b1-4ac17471091mr389196465e9.6.1793807838445; 
 Wed, 04 Nov 2026 07:57:18 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec8d8e29sm4816216f8f.19.2026.11.04.07.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:57:16 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 15:57:14 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: de5de87aafd7ad3390d7c748f79a37cf6dd6eb24
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 15:57:14 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e35e9fa93e18068f1e00b39184f9ab778c65e467-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOdMb-000000005Lm-0VAk
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8653789269449158376=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8653789269449158376==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="I0Tmd2Fod34="; charset=UTF-8

--I0Tmd2Fod34=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Lev Stipakov=2E

A=
rne Schwabe has posted comments on this change by Lev Stipakov=2E ( https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail )

Change subject: con=
trol_msg: Add a shared TLV codec and use it for early negotiation
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comm=
ent)

File src/openvpn/ssl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1965/comment/f78d1db2_263a1081?usp=3Demail :
PS3, Line 2665:              =
   }
I don't think this is necessary=2E There is no problem in accept an op=
tional bit here=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1965?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Change-Number: 1965
Gerr=
it-PatchSet: 4
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerri=
t-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Wed, 04 Nov 2026 15:57:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Label=
s: No

--I0Tmd2Fod34=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Lev Stipakov=2E </p>
<p>Arne Schwa=
be has posted comments on this change by Lev Stipakov=2E</p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">View Change</a>=
</p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1965/comment/f78d1db2_263a1081?usp=3Demail">Patch Set #3, Line =
2665:</a> <code style=3D"font-family:monospace,monospace">                }=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">I don&#39;t think this is necessary=2E There is no problem in a=
ccept an optional bit here=2E</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">change =
1965</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1965 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipak=
ov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 15:57:14 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: No </div>

</body></html>
--I0Tmd2Fod34=--


--===============8653789269449158376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8653789269449158376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8653789269449158376==--

