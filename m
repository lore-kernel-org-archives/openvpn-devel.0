Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87CBCDE000
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G4fakHPU5VtjvhhIYzhijgEoqbTgq/n7CsdLwsrnclo=; b=PTAn9YQkeH/XQTo8yO7L/bXxw4
	Ia8R0o3nxLNZEA4sDn5+ATh9cCPyx0gewdCsOxIxjHP+sQV9Imso4C/6KQLRqWxSihqrmfEi025ec
	FAGKqlhLAEy4E9CyGLK+5WNFwrOqdROrHXfw7Nkzxi9Pf9USd96t3VxE21uOsCfKOwQQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcjoi-0005n6-Ng;
	Thu, 25 Jun 2026 13:08:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wcjoh-0005ms-C5
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:08:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=er3dfyjNIBSboc/kQft7KmSgvE5XgtiojfAmuyXRqx4=; b=gNXbV40KfM+D51hquKtFGAsIYR
 ORwE+fIULBQ6mGrQelpCVvYHTmCzIrdhoYn4dU7OVJvq9tq0cS0VZqvGbVc7XWpCOAbGWYNNx+We6
 1kTOVGIwo8c2rZ67VEk8fCy8+ahnFUMwkfA9r1BIubx2F0l/ha4He+ovjFPjnbQ4p17I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=er3dfyjNIBSboc/kQft7KmSgvE5XgtiojfAmuyXRqx4=; b=L
 WmqSZB+bCukKqrotRH/0jET13LG2VI2WuvaTgp+u9GVUPajXFluuRH4/LpixFqrRIkEff0J75l5Vk
 jotoOnIkTWTEK95OqHN+0mpcmylnzocC1MU20ylrClU8UAP0QshHVEN+lHQi91+BfiL5cC+DdYSWn
 nMEg/xYRevb6iUc0=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcjod-0008I6-CC for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:08:28 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso12379595e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782392892; x=1782997692; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=er3dfyjNIBSboc/kQft7KmSgvE5XgtiojfAmuyXRqx4=;
 b=DrvKs62gQwP+pfgToolHbRDeT0JfS1ChqS9nX4I8zXLEN1SfP4jGa4gxfta/3hllD3
 7n1LXbzo34T3i+LFq7/nhUHpiit2hC6z4H2rCMrN8dGGpd0DjE9PoZJVR1Spe6X7qPZB
 C65JzkND4cMsz8IQeCdJenyBG9aWxL0w/aAqua83gEwD5JaAlpTlvX9rXK5vGOOCzPgj
 XWQnvNBVPecx+BhLolPXYK1477t7uVTZ4rHZC1dBPcQPYyhEtU/MuMa5ROMHqPl5vvZv
 RnX5q10c66T2gN/yhhgQPNuklXfbRiI59tZYEkpmKsQV/P3vAKZp98cLLXS7HsqiNT9y
 edNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782392892; x=1782997692;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=er3dfyjNIBSboc/kQft7KmSgvE5XgtiojfAmuyXRqx4=;
 b=Q7umF8ku/lwecQ8U91eRnD1vOhQTcHzAx+Q8ivMHsPtaVXUaNadb+HDe642q4J03pP
 RrqcQba7bd7NuineZGwW3ZNbhYrIEarWxgVmuE6ActvKFLcnCRyQUOJjBExbiNSXdqBG
 9VEF/aiOOjKNEHIwgxwhCWHupxGBThnOdhNux9uy78dv3yJyYtX5Iz6rcncT02JcjvHb
 FKRIueYYTWuw0WtHKHhVJ7QjCDS8XZTKGV5mvSFY+jCwH5UzL7ji6YfXmMMCLlAJcYqA
 UsmBC68c85riToQz2DRLsegh/R51KVsgZ8y73jkNZ8wBA6xepVhvl2PwM/zerbsDsagn
 gvRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1K/zLLhJQmN0LW7noiLlcrHy3PukojjmxnR+Ksk60pID9z+TrCin31QZvwDvlBIAO6j81ufBwG+zPuZDg@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyOv98YhNlOc2kgNvndRE/3V7yYRcxQEKEW53Cci63ie2I2WaQW
 8GrLvaQ2WQPEgqqPxKiCFMAp9BIaleY8sQbdjgeslErskJQXvjEpeNzhbbgE2i9/VN99sd/omcE
 H4+Ja/klpTcIvz4eUcNqqkkjnNTY1dNE6s5FaVYR84+hjWkjgY2Ay6Bi4o7Hvqv+pg5HI9Knqiu
 9jnGNkAQ==
X-Gm-Gg: AfdE7clsE0hj0/oCEqiM3C9GOgCrRWZf6dvy78n8CHoU/YEqB2s1H5xyz4dqX1VZdAu
 BZmAhTkYYz8U5IHMQ+RuzxLCHRdl9IyWjSfM645X4Hlpm1sPV3TOg22PPED3DEZoXVGiYh1XlFz
 4k+C0prxKzL49q4kq4kBH+ZlGcJjHl8flW++KCXt/y1otdz8wb+d8ABEbPhuMLSgY2ZhB28mpgE
 jndXoKWoD3UAZyxokQ2qleKJpSbPBHWMEi8l4w2ocaoxjtM8JiEgwpu0h76tOUEhfZheWFqfYac
 6tSbhiTFXAdG8evF4dA7cIGPD5UuT+UYEkPTZQoXYT5lgzLTHXa8keanZHqtUFU1eAU0/UCkk5V
 7L8EpGRxIUdlApSMkJg+jPcw9bEeFaCKAtY4BN5gF7iHJvED+2PACfPjvaLnTvdaq+bPG0nMDd+
 av66IMA11y4FKl3XxobxWofGNOqJfgSgWNKAO8bwxxJSm1eCiUr+sDq8oDf4HHMOHiUQSvq2bXc
 Lv04pPvaJbPPWEqAIrLKG8kNLAvdFNt47KRVGLNr4oQHx3gRoo6dJhT7NtmITs4lD7Dg1VR+ajr
 HHo=
X-Received: by 2002:a05:600c:46d5:b0:492:324d:e93f with SMTP id
 5b1f17b1804b1-492668aa926mr30078335e9.36.1782392892108; 
 Thu, 25 Jun 2026 06:08:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492649695c9sm44528265e9.0.2026.06.25.06.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:08:11 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:08:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de
X-Gerrit-Change-Number: 1720
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1720?usp=email>
X-Gerrit-Commit: b6d62f43e76d30a195744dd5a129389b3c23327f
X-Gerrit-Comment-Date: Thu, 25 Jun 2026 13:08:10 +0000
In-Reply-To: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
References: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk2YTAzMjQ2NWU2NmI0OWFiMGNlOGIxYTg0ZWFkOGQ5YWNlZjkxOGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e3a32960e72bfb5e59cb90c281559f9750f33630-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wcjod-0008I6-CC
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 handle_connection_attempt from multi_get_create_instance_udp
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0519614515391143889=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0519614515391143889==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gq/x+F2skSc="; charset=UTF-8

--gq/x+F2skSc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1720?usp=3Demail )

Change subject: Extract handle_connection_att=
empt from multi_get_create_instance_udp
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

File src/openvpn/=
mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720/comment/7faef22f_=
655850ed?usp=3Demail :
PS2, Line 197: struct multi_instance *
> should be s=
tatic
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720/comment/e7e1b63=
f_e446b25a?usp=3Demail :
PS2, Line 198: handle_connection_attempt(struct mu=
lti_context *m,
> should have documentation
Done



-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de
Ger=
rit-Change-Number: 1720
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu=
, 25 Jun 2026 13:08:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
=
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--gq/x+F2skSc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1720?usp=3Demail">View Change</a></p><p>2 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720/c=
omment/7faef22f_655850ed?usp=3Demail">Patch Set #2, Line 197:</a> <code sty=
le=3D"font-family:monospace,monospace">struct multi_instance *</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">should be static</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720/comment/e7e1b63f_e446b25a?usp=
=3Demail">Patch Set #2, Line 198:</a> <code style=3D"font-family:monospace,=
monospace">handle_connection_attempt(struct multi_context *m,</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">should have documentation</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1720?usp=3Demail">change 1720</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1720?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comme=
nt </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1720 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerr=
it-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Thu, 25 Jun 2026 13:08:10 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:non=
e"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>

</body></html>
--gq/x+F2skSc=--


--===============0519614515391143889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0519614515391143889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0519614515391143889==--

