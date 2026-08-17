Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F1CC5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ih23flZhibdi4m5AVtqqRG8r+CsJWVDLzV2mqAQuwwc=; b=e6DG6gF0A/r2i8IJtKd1ERYQ5F
	Dwx4H2x7FfhZq+RB/v4A9USTo1xNPXBOqo4bBZPHcWtOqnVOW91WH71k27vzT9fhLln1EE6JLULqs
	4ykahcUqydy9Vhsnn1MJ6Q8j8ZWpjDUMT31JpEexVu8rV8DqdSo1ychONYztmwYf2SWg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvzX6-0000S7-Aw;
	Mon, 17 Aug 2026 15:45:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvzWr-0000Rg-Lx
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 15:45:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JFng4Bng8oy9yMRF2ZBJUptbSC4I8G8ur0+oDfCG0Lg=; b=UCDPo3KY4y4Vn/qa1X9ZuWSkuG
 OGu+HKJ/hHKYlgStCRRClrrbNKP7MLz8HHqkiq3SiatlZ4n8DpitSRXxcvExRNw0Era3/HY5BHX4/
 972FVxngwEPfjxG82qGJxQ9/Hqv68d9eSKyQ5oKNTXjmMiT6V1MGBT638JmhVLgecWKw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JFng4Bng8oy9yMRF2ZBJUptbSC4I8G8ur0+oDfCG0Lg=; b=D
 FQ9wI8+3oBsTIi+IXlt7mMP1UdAbmkh8Mmuu0px3TW/+lOk3sdwiOUlzquicl/RX9U/t5JhSZScRu
 drBxz05soqnUXeEwHroSv0SpD8WU0K8Ch7ivnKxYyYTMfKrvxv8y9y1QCUczrtAuXSEonV3v2p+F3
 BiPFL1nP3FP5Be2k=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvzWs-0003zs-40 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 15:45:35 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so42203535e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786981528; x=1787586328; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JFng4Bng8oy9yMRF2ZBJUptbSC4I8G8ur0+oDfCG0Lg=;
 b=Qq5P9IY+T/zKlg99JEcNjXN13O98DkI4HEeuhwdFVcf40V/ecgCmdQLN8E8PIz5vp+
 X91oFVU+5nqqkEJyuTOjHAsirS+stZhStTzUCC7uK7avXt/L4VC506em25mT6Mue5r+A
 BergUvEIXt7Bulh9radkHqYrKcU2nIqpev2FVEffkvocSytTr3PFYyNXVv3pgi1YHaoa
 iaLibl0m0JPjizcFSVEVnanHVjLzO5/K/au4ZASmAdk0nox/F+47hd9IZJEtmtzYnwG3
 O5HuSpe+yFf4nj0C7YV3jJDu9dCjTAThHlew8zH4OVGjiQ9P40WKYoLCzPA0am4le2Ki
 nSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786981528; x=1787586328;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JFng4Bng8oy9yMRF2ZBJUptbSC4I8G8ur0+oDfCG0Lg=;
 b=rse0lDvSB1jGAOu0WgotGyEchelqcL49I8V9xWLquujtxTdQsVBNs3TXvhX3ik3Dz5
 sF9GotYm6LG3jOQO4+irWX3+6jADgY4NSYOXqNPMMT7AFJErEtgCDQToTubFtk8GYYPo
 EoY/YQskQDaMPTL3EmDlUI8TCZcQANZmjv3IhVtUaqbQlc+cma1cxKvSe7EbWeU7q6x9
 g5kfIvuHvJcV7gcmuhrpPdnaWXBIRddHwezEd31FCkBP6H3LYxtaaNUaId9FyFNb73pP
 P1KR/8txjKlVtViuIfMf9SiN6+1t3/24sPf4DPFi3YW/LOhY7ZCIRspYvdB9t+HDL2Vm
 NuJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaljoI3ag+gLSl5MFBazsMSq2S5x8NHPCC9KqnHEwPJEuEA7w6zaLcW3uuNYdcMwe1Na5a0tzC6zx2LsiO@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzW4pJIkOhsvrjMLLWAqHNss7lWOCQu25wTVAJfu1OhdCXxPMRw
 scIiFz1pUTMYYbyd2oGkrk8mjWSvXykBKWKiYWDRJK3g66qNAAKHi2fP8HHTlochGEkROGIm6FJ
 JuAU9Hr935ATRBOgRZ0IAY3FBmieIMJFk4rdCELsnlNiK8joDeVoRD+rf+rjPjR1z0697
X-Gm-Gg: AR+sD12hoZqN89ybfeTygRDv8Fqj0zT0R6TpgeGy6gvVWTAIOoy4mlEULP7er2dOH4o
 Xk9PdYIZcxz4m68DTkxBpSHDWo4+URjWudy1tMWjq0pvlM/9iRejKfEjOndohcj1DdsTVq2URON
 T7eJ3Zai3k1ajldNTgcGrw5ZhAIHWB2whvVbZDg808sMKJnKAvWLyaAxJkt5CYXs7YhGpjX6+AM
 Vm4WHSW07jUk3CPy07YBd8vOljbnF7RdIxOfwfLHGkh7g8sZGQZ99eze8JSUFHggLc/w+oXCWxK
 MNNcbhzHBvKXKoWV1Dxo7tRPhalYKio2coZOpyUkiidLnamAf7jlnjBv0GnvwX5bBLWBGW1ZDuA
 okVh+dDA6Iny7bt27lSGw5vRlVfVII892zks33f8ko8fFcw/uu2G4QGBF4iXA+7o3OPYSV45lJN
 ILwTMty7k5t4HCPru/7E/8jTILiB//gzvqtSqJZ9MNScRriaISdXlhd0cX63Z3OPjtiC2MNOipK
 0Orn6ZRZVJ90HhcUEb7jFXVuubCIF3i+fNbfeM/t0XxoRGUo+SAcvvUiQJ9a5//yUXJrdJyXUVJ
 5JmdqyJbcqH90+mtdsmx/lq1jnokUBfkkoKFAVALhdBR94fmTi4=
X-Received: by 2002:a05:600c:3b23:b0:499:8ae1:b900 with SMTP id
 5b1f17b1804b1-4998ae1bb69mr320691825e9.12.1786981527868; 
 Mon, 17 Aug 2026 08:45:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d7974sm195560735e9.1.2026.08.17.08.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 08:45:27 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 15:45:25 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
X-Gerrit-Change-Number: 1772
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1772?usp=email>
X-Gerrit-Commit: f2165dfdf57e6037d5a43a8b6226c98d088b5b4e
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 15:45:25 +0000
In-Reply-To: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
References: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2MTc2MjM3NGMxNDE2NjJkNTk2YmJmODhiNjRjYTdmNzQ3MmI1MTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7add6403bc307e7529d054333018148844463c5a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvzWs-0003zs-40
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: options: Factor out
 options display code from options.c
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5891093577929174499=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5891093577929174499==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4y0ncRcp+7o="; charset=UTF-8

--4y0ncRcp+7o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1772?usp=3Demail )

Change subject: options: Factor o=
ut options display code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review+2


-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5=
149
Gerrit-Change-Number: 1772
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Comment-Date: Mon, 17 Aug 2026 15:45:25 +0000
Gerrit-H=
asComments: No
Gerrit-Has-Labels: Yes

--4y0ncRcp+7o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 4:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">change 1772=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6176=
2374c141662d596bbf88b64ca7f7472b5149 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1772 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 15:=
45:25 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--4y0ncRcp+7o=--


--===============5891093577929174499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5891093577929174499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5891093577929174499==--

