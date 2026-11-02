Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C0606A329
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=h+3r7dy/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FIz2sob3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Pnc7z34U;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GDdOnjYx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NVuWHkTsInFZPI+QahernmeJzle9M3+YZCERHWQmknY=; b=h+3r7dy/tF85RUhmtj3k1TyvWV
	d3IPFlqARNFzZp5YD7K//rXHpKmq8nL3+xQ+3b//n0Rge6fdUdXhJg7Rm/lVpJtzCzXXWUdQCNJBe
	Kzf9R6/p6FqTMTIYVKyTBS0THc3Lqxdd8OFVeLIwmoWHIlZYagAx9sXOZJ142Ljp+k1o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNqoc-000000006U2-2iQi;
	Mon, 02 Nov 2026 12:07:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNqoV-000000006TQ-1x7O
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:06:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q8e5JWV7iw9/zZkUhBa2pRLPRetnu6mATCEJgK1vc9s=; b=FIz2sob3YHNQ/OMFmu+s11a9E6
 iVOy/xWxjS4aQgLsZhWNBj0rzcj0hqJpxjOijtb7uX/4e5dsnSVFVtvfvTAkJkM+EDb2dkn8alaGn
 UDixSAsDPBwV59jsW/RcaKhPJMGjx+KjN5Us/ea6jVKShoUToMjphRIdR13Pafs5wc0k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q8e5JWV7iw9/zZkUhBa2pRLPRetnu6mATCEJgK1vc9s=; b=Pnc7z34U3Wbxg7NR1f7CRXcNIx
 EBbGZQAGw+YHS/I3KnrCiIOymu0JDlaD+450ogDrWDGc6hLroSIae+IrOqOLj2/aFy8iEIVQNpTDK
 c2e77BzWkuUJLPhNgNZF+Zufpj7xJEBjzEbbZHlVL3sj48Wa1hZATeh0OahbgRnTvKSY=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNqoU-000000006JF-0UCJ for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:06:59 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48b042c0728so619281f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 04:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793621211; x=1794226011; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q8e5JWV7iw9/zZkUhBa2pRLPRetnu6mATCEJgK1vc9s=;
 b=GDdOnjYxL7r5QN3NgJeOD7c5M/Z/HxH+k0dJEIIhd5qk4n53CC84uJUslBaRizPOrG
 KgsfPNGgE/GhL6ZgE2NmFLtdl4Uz/InLE/kvfqoEUy72idq/piIS2Ue3/3o0U4O6c4K9
 RCq0I87HkbFNOe2PSgwtgRHjc+bO5TM083fo4QyaNaKqF7XgbRwktPPFrPMEUSZlGqhu
 999dxoevJE74X57FOV7Ox37HCJMZlvOruf1q9+/x7OSEbwsrVTJ9ldvwQdNlXnrZD4zC
 5ilp+98z/xL5d1TWbP6wk2KTRQfGTgShVZ72sVgEnPvalaqyavXJ2vjJvZIGAXNuL7Wb
 cyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793621211; x=1794226011;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q8e5JWV7iw9/zZkUhBa2pRLPRetnu6mATCEJgK1vc9s=;
 b=Gw0wd01TDBsFobMYO+TSjZ8ibvvLnrst+U0d1rrg579uNTljXQHTW7X1W9jXMhPfI/
 S9QVCnJAshIwQVIeGHE/vohFMnuM6ux++pxI6s2AX2gv8XjCZ3XBHttScDRi8UvxtHnO
 PYfYJ80UZVtLoBBnAWUM7RVDel0/6+jSl+QTxy9VPV5hBidTH+IoCQp+8xvA9dDYszdU
 BGdtepgIgoBmhjT2qt67p2yZpfsoASrj97zCG4sscgDLh+5XqYatMM2pS3m/aGGqtjPg
 EkTGTkEv3CMVpFlXK8bmsBTS59s5VhGKnFcVjCT/b20MoBohH32JPDgtQWEgInjjuu5S
 vggw==
X-Forwarded-Encrypted: i=1;
 AKwUvBynA12wCVhIJFL5AP44eL0a0L3s4+pdO+f3nJlHV2lOh6afX6FUZLuVkmD+b5GixDOc8Dk6xt0W3O+nOeFN@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9VR+lbNgqNpWFNCQdjt9zZPheHoCJMbeu4X4AFs3QavZzLo5Fe
 RESvPE+nBwVZpIlimhheW0j1h5HAonxRlWjFat/T6fue3jcetocmrjVipM/UmeqB7FVWQ/z9mBP
 zexFWVRhW/pGv8w5UYgBZBlXtLxwfnqSPDYVQ9jfrlVi9QuBpdlIHEZnTK5DG4aAb3/HrttZdMc
 xvJEeZtw==
X-Gm-Gg: AYBFou0Ss7fFKnjXu7jgYFmDhJEsGQNaInywKQHQh6GDaBI+WNsWqeFJs8r/dBqVSbr
 /hJhtDrh+IW1ininE5rdQNtZX7IsCDNzdlmLJabITXwtvkvO/a+Ryjb32GSPAb0ZKpRuPInilVJ
 DGbOj1vB+1H2iACy32h9S+/PYQhOMOmjKDffBdFytEkiME3JM8prF/a6oAtsZPGSInc7/b3q6os
 2P9f5eQndxl/SWDHbhcf0d66tajp7f7xnTuqwW1jwmgji7vE+vhzaF1NEBJpUBhQ13GcpiXqa7W
 4T+AgcjvOuA+Md2iRxr03DeliktwDazOzHkLfNNayW4M9N0mEG/5qC/qLzY0oFFqQ3DyUTGlIF0
 5W7osebWFovtdp59bJAdr8PI1MA6sAUEeaGL/Zls4KOLtGeIYpDlvsHvdoC9ZHwavAp091pIl2R
 /7c8vI8bgw8dwKbEfCdqsTvSksR3XAjDiolXAdR+tkCWjHw6J5mRFweDYxi/sa3lq4GNUWT48Vs
 rAL/xxqZUG94L2t5HGU+QCVuf12ylJJlUXQAZqkxenKYwZLv64NDl5vVmqIrBaPPO8kXFz0+I17
 0cPsM7SHJnes/ZvcgcS+G4fs9EXUYda0b8Ss9htMoRgV3skqAi/5xWbqUQCp8d3XHbyPhj8JvAp
 n4GsjLHB1UnTk9yN73WdcZ4E611SwJYWUa7qARTW9QGJG8+xdjioN3KMmX0xJOcgNElJsPaF1xP
 HRiy0Zr2zgi/fWvw==
X-Received: by 2002:a5d:5d82:0:b0:488:823d:5086 with SMTP id
 ffacd0b85a97d-48e6e2626aemr20470230f8f.0.1793621211334; 
 Mon, 02 Nov 2026 04:06:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78c10sm19268322f8f.25.2026.11.02.04.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:06:50 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 12:06:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
X-Gerrit-Change-Number: 2085
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2085?usp=email>
X-Gerrit-Commit: c0cb4cd1e1bc6c6fd946387680a5a77edab3898e
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 12:06:49 +0000
In-Reply-To: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
References: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MDcwMDAwLkliOTE2NGUxYzhmNWUwMmEyMjUzYmJiM2IyMzYzYTRmOWYzMWM4YmRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9effc641ceab3453f6c6c5861cc8f473fc622bb3-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNqoU-000000006JF-0UCJ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: check
 parameters for NULL before strlen() in send_cc_message
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
Content-Type: multipart/mixed; boundary="===============1378973987899799493=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1378973987899799493==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LSocTUxnoA8="; charset=UTF-8

--LSocTUxnoA8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail )

Cha=
nge subject: init: check parameters for NULL before strlen() in send_cc_mes=
sage
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2:

(1 comment)

Patchset:

PS1: 
> I had added a cppcheck suppression =
for this=2E Please remove that=2E
Done



-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
Gerrit-Chan=
ge-Number: 2085
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 02 Nov 2026 12:06:49 =
+0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>

--LSocTUxnoA8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2085?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">I had added a cppcheck suppression for this=2E Please remove that=2E=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail">change 2085</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib91=
64e1c8f5e02a2253bbb3b2363a4f9f31c8bdb </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2085 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Mon, 02 Nov 2026 12:06:49 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--LSocTUxnoA8=--


--===============1378973987899799493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1378973987899799493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1378973987899799493==--

