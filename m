Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B0AC5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y7wgBJY++2z5dhC90q+dDRvex2eBKSteklZ23L1bDlQ=; b=hfbDVXsTCGU3O4MO/FrS/apCq0
	6F8jQoKSlZXUgTAj0TJxOsyR9Zccl6emf6PlYBl25VjmWwq+rdinMQ/i+vwKyizf+e64j3533K0cP
	4v1rWUk7pAOB7wuEgKrd69dNPCAIi7P7kJ/orWmg1BxQM6PGs/NCA6DwXPSrYdoez3yk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvvh0-0001Ph-Fp;
	Mon, 17 Aug 2026 11:39:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvvgz-0001PY-Lx
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 11:39:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=z3g47Jn/6pZC2WqITj60zsEj5gvstILndo0X/loD4lw=; b=XTp5Bmq6HCAElxRdgcViFYh4+6
 Cj87VVhiQOaQMxrM60x6O0364FKvDZcKDXgxWxN+If/DNWC8kyXFbmBqoAwUoorNhAF3wQD+M/rXC
 MK7EH3zPx6FlgG3/MpMIGRXLn45teQQnzOemMpwFH7jZ9jbSQ1m6lHUXzztMznsTsMVo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=z3g47Jn/6pZC2WqITj60zsEj5gvstILndo0X/loD4lw=; b=R
 hgZTiR+13inWkYMLVoJZpfwslYLVxbrPQqTWh2JBpczCAbKbnFmgUnb/4pAXBqErCMEax09T5YFS5
 UepwLYe1nndbeWbGSEygzKd/M5EeChrTd9KGjWJ7jhlMD1iOh+hJu3512c2x9S/ZVR9nmw7iZLZ/s
 QUr9YwSc2fR3Lx6A=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvvh1-0000Q1-QP for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 11:39:49 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so2896066f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 04:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786966782; x=1787571582; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z3g47Jn/6pZC2WqITj60zsEj5gvstILndo0X/loD4lw=;
 b=Uv+yK3w4q0Ffg4U8/gYgU8Dtnz1hry+chUj5j+i39cZe1YzeNwug2i9rTZzydvUAI1
 DTObs5uo7gfwbPOQvt2jmu+LIQ4EYLSoijIRtNQ7Vojg3m4Ftc1YV14algqxNLWUv1t5
 zC+SxFNQYEjJA8DWRSoliKWkvOj1ziotAcKFNkE9NVVgb+mpBNp4DbgCL6vdFa742bnH
 TH7zFuegKSuGsq5u06dLd8l48tbuk/cbqrTP9Wl89Mb8KuRE+6qfybbtlDOM57uj+7lu
 3iZ6zl9G+x49V2Xl70HGLiBPufkMSGxusXAA6wpoUp11peVP+HpZ4fZ+auMv+9lnx/P+
 t/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786966782; x=1787571582;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z3g47Jn/6pZC2WqITj60zsEj5gvstILndo0X/loD4lw=;
 b=dP+t/R5of5thy8bDWi2xHnrPfhFG07n8gAT6Y0LcY2UZXqSpPTDNN0omK8tTx8thVf
 SHBCUiRmdPLQ/7yivY/j+HRBFX/WsMKlbLpF0UYcX49mirep05OPnTd8Lqs3JuYDn/Oo
 Xz2Sxb+EkrmcR8d/1CO1F0qPGhPs9u1h01jTzT4FxubN05RpuJDSRWGD8eb94W53UXts
 V1rCHun6DbFiWQccKKMYsq8Qq8ZfqkyMrB5YiGi1+CKuPH64msgJjwWNXTTMMg+lzqqY
 UICN+U+BDC/JJITzEevMlZloZx7IYeqcy8AC5q3HcWvh/AOv3hHa6GCvGapA3zC+Hk+P
 ZZgA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/05uUdw2SLIdzPFxnV4WfLmiFAUixDHcmYdbWZvi4PETFUbffoB/TQPc+CpmSTPHydKPFQiTpy5WIYISh@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxBtUI2n3zq1bgTC7gzgfpmba6/Gz6BI/YjNIIRXJD9W41NofJM
 VHv2yJBTOJUno25DY5cJ4yGtowj0+/CYH/H55OtIIGAuujyrdsv4M5AisWfj6xGcU91FwexiMaa
 cWpO1SO/56aJxVn9xUktBbD57vxCK761ZQSjbE6Mnws2jFsAvcsjKBbQ27ByXiEDtIRxTD3XG1+
 RexTCdpg==
X-Gm-Gg: AR+sD106YPheWqYGJcaIDKG834rF6YqjXqMPTsXxWjbgT5QKss6rHv0LBl+dvuqFPRp
 JL55uP042eclXpY60iwl/2dwRGoBFR9vnLnArltpIuGJIjGV84LXttICoHvAMosFdYtiutFioxY
 M0BJ0YJIT8bfGPC0ySJYahC3ME8S79bSL1i+QfigqZsQb1BImVSSq3sdattzE8KG0qZQBKD4A1D
 56n5OFYxDfPQ17uwF1reiro7CWyPIHSUO3vHfox2Qk5iGnIEOO6C6tvKD1gBYHS6+jD8myhFmkE
 Rva2FOc6cTp81tR4S0TO7VmGbPor7g06f19R/4EZrST2HGbYWR32N0vyChmDVnFjXfUH1Sj87DV
 Qgsvoaothp37ZhLV5uzBih7Xp3k8X/F2Cx4SBi78rtgE4DGYt9e0U8cOtETeDX4H+87NeTkpNaw
 UyUpfe7gucQMkocfUXrUwuCg3u7Hus0qOt0I1AjCKesSMnjoK8nTGNcc52EppnXcHDsxKgrzF2Y
 QpPSuYNoaPk8xe/i6/jLJIwMYbBPfc5sgA1KgNDFOZ+K445duU/3IpNPZ03x+F0E4cw3hSHCgGp
 PltDQDIv2sk8xuLZrX0iYM2EM0GAoO976/MBdEO4RswGZwHbTvw=
X-Received: by 2002:a05:6000:2406:b0:481:5f3c:39d4 with SMTP id
 ffacd0b85a97d-481607368c7mr39821939f8f.1.1786966781496; 
 Mon, 17 Aug 2026 04:39:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3157fsm3263490f8f.3.2026.08.17.04.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 04:39:41 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 11:39:39 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: 0ed03b5aa12f834249b9ecd2e8edb20d5e4d6fef
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 11:39:39 +0000
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cb0fa2ff05ac2953b9a5bb7361951fb613448468-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvvh1-0000Q1-QP
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make required action
 returned from pre_decrypt_verdict more explicit
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8974796017845119845=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8974796017845119845==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+R4CDDFQdnE="; charset=UTF-8

--+R4CDDFQdnE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, razvanc, stipa=2E

plai=
sthos has posted comments on this change by plaisthos=2E ( http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1826?usp=3Demail )

Change subject: Make required=
 action returned from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 8:

(3 comments)

Co=
mmit Message:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/e3697=
b68_91d649b0?usp=3Demail :
PS8, Line 10: is defined to decided if session_s=
kip_to_pre_start should be used=2E
> Typo: "to decide"=2E
Done


File src/o=
penvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/b3=
76acc1_2bdb8e9f?usp=3Demail :
PS8, Line 282:                  * state is us=
ing the same */
> This comment now appears to be stale=2E
Done


http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/0a45728d_36e85f12?usp=3Demail =
:
PS8, Line 283:                 if (session_id_defined((&state=2Epeer_sess=
ion_id)))
> Is it possible for this check to be false here? [=E2=80=A6]
yep=
p, good idea



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1826?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iccdd4=
cfad090c565aac27e16cdaa9871106c2f89
Gerrit-Change-Number: 1826
Gerrit-Patch=
Set: 8
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: stipa <lstipakov@=
gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Attention: razvanc <razvanc@mailbox=2E=
org>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: M=
on, 17 Aug 2026 11:39:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: N=
o
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--+R4CDDFQdnE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, razvanc, stipa=2E </p>
<p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a></=
p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1826/comment/e3697b68_91d649b0?usp=3Demail">Patch Set #8, Line 10:</a> <=
code style=3D"font-family:monospace,monospace">is defined to decided if ses=
sion_skip_to_pre_start should be used=2E</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Typo: &quot;=
to decide&quot;=2E</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1826/comment/b376acc1_2bdb8e9f?usp=3Demail">Patch Set #8, Line 282:</a=
> <code style=3D"font-family:monospace,monospace">                 * state =
is using the same */</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">This comment now appears to be s=
tale=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1826/comment/0a45728d_36e85f12?usp=3Demail">Patch Set #=
8, Line 283:</a> <code style=3D"font-family:monospace,monospace">          =
      if (session_id_defined((&amp;state=2Epeer_session_id)))</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">Is it possible for this check to be false here? [=E2=80=A6]</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">yepp, good idea</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">change 1826=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iccdd=
4cfad090c565aac27e16cdaa9871106c2f89 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1826 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 1=
7 Aug 2026 11:39:39 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=

<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mail=
box=2Eorg&gt; </div>

</body></html>
--+R4CDDFQdnE=--


--===============8974796017845119845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8974796017845119845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8974796017845119845==--

