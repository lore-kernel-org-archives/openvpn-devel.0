Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BCAC5AD4E
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 21:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XtbVlvwoxZxS5vzBxSt//mRG2jL3kg81AR+2fDLzaiM=; b=DHTFCk3dwlUD/YrxPCp5GInLxB
	jjeXDDdORgqnUf45u48+Dxvdzs6r/uvAgZVGXnDTfx4oZhv8LaWdAIJXg8uEhFtQjo6W1grtZqvK2
	Qd/oyyU4a2Rtw/+BA/XCVinJFYwAFJ9yUIXG4ScX6XzZ20zY92HdO9IMCEoiQZKCS8uw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsoyf-0002pq-Hh;
	Sat, 08 Aug 2026 21:53:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsoyd-0002pk-Uj
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 21:53:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yAcxKbM4pB6nddP29CGeap2DVBjVaekXAN2myWv+cl4=; b=ctUcfEySGDbI5WhEU6ZPdcaozC
 VAUysDTfZJE9YmQc4hvJ7lqd34YfitZoRKOe30YEnkJpQYfMhFGXINvIpa0lNWUtx0xzAZfkUpiyY
 QRicJg2nCcTZcyfKPdJQ9h6iBIuLdAPkET4ZhX4/Qgmeo/GXj9Tt3nxWsSjjTKt4aEYg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yAcxKbM4pB6nddP29CGeap2DVBjVaekXAN2myWv+cl4=; b=j
 98Su84wKVGi3+5jjqzu1ofjnOYxyY3a0PDfBgsUEde5CMvl9BD3sAoipbBLqVb94VX/hZEQM3YEb0
 taCZrDYkOPZJw81Dy90KHshEyuYUSgWFlkpvBrXUNwK43OrkTWUAoYdhe2RWPK4z8lKY9PCi8iBo+
 OwW4ZoUYbZiSA8BA=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsoyd-0005E5-Ll for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 21:53:12 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so7666365e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 08 Aug 2026 14:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786225985; x=1786830785; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yAcxKbM4pB6nddP29CGeap2DVBjVaekXAN2myWv+cl4=;
 b=edM4TEuGNNnce2Cx/ZZS3T48yymp5qxgHyC6Lf9STR+Pad7to4tY0ge2ot7tEWRYFB
 4CcrrtogGIbJTPL5kqbZcTGIl3wQ81/OJd5AW2D55Pf/UkBjMvtM/rgAypsBzbZicGZG
 Fxlop4miUVTdgr6iWMULySrmog0WPgbBvrRkGfEXgD4eNKYWsA8hHyU9Up27umibR0u9
 SBqMvRzW7q4wEW62OHURnUa395d9vkbiwnEp0MCr1RAnhfSaVUoWw6yqNZZ9EWWlnoX+
 DPVdJQ7L/qkk9wQxtc8gCQtV3duxRK++iYFgIK43PE2aJb0dfHjnCGVktJoMOEmLVjkM
 feFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786225985; x=1786830785;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yAcxKbM4pB6nddP29CGeap2DVBjVaekXAN2myWv+cl4=;
 b=Kg91bxZzG/C3bI242Sgb2W3Qi5FXbgeheS75t69UMVm4oDqWxZa7dFn1p6Ndps0tn1
 SYSXbkgdOka32jPZoWX8esVUpbeznZyYPoIdciNn25/gaImFH2araW/chy7O0glZNIxh
 vi0B3DfEZgN+/tX7SdCb7mWCmQnC6jMsLUgbiX1dxHAXME6nieFu/0UBAtWugy4j1t6G
 VyeGMYX8H/uXMnEsQ9E3YDDXN1Ae6BcjbF9pglBU6uhx2YWPFwXBIe6NKo9hVWLdQvjp
 yBsKzg5K9ZJN3cXhMgbMJewZPws7K+zdyUOnR2zrK+vUSH58ggKsKa7jHp5cqHTo/1my
 xx6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHmbq2+KvxLBfQYxNV+SdRX7p3+N3200RpmCCsevuIgAV0OTi/W1o7fqUBwATOzqCNRk+UStlhoMvk8MSE@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwTPaWjq1OKjpzTYKmFRAhB/VEV362xOIoshLnbxUXFakLqCVgy
 kV08lfwC3hfpkntv89pRPbjX8zJeHG83atvFqoubaAtKSfyLZLgsGi6i4UJ4vjBTMOZo3iug5qP
 J5fruyOnY41g/qnf1gi9q+WoED74iri/BEPVPrkuDYgm6oMaEhfINyOPID134oY2gqkx+64r40W
 RoyT5RSA==
X-Gm-Gg: AR+sD104PYbAn8NrH+LrjWKGp4fBXkoTGYdLsgrBDin5y0DPcxWu++ur4KjpZwheS3C
 pA3dX1XEkfMIzD1Zkqd3PUCOACbLeIfOGxzokLROjg9nn01Vr8SvkIAJGSg2O549GNsOT0mvt4D
 Bos/fxz5BB54pTxukcO6d5bjo6lf9HHdRIMCoxvzajCXgWoSkE4ill6PR1Z/om4VZM7Hv/oc/ex
 RXV+qohubdvAIIbyAQWMOQpPblEdRp5U0f0sEaHgQB0xfcnovPYjqVSCvHtAtZb6Hgb7yygc5Pr
 7akJRcASxIbZCfEE6P2oKkuui0brUlFxv1h6DGRqWGuZIdYt9uQvc50kKa1ieffdff8jt0rTHCh
 Jqhm0aHhfhjh1ehxoNalTYMi+ucHwUH/d00wOULg3b2Eh5oeMN2H8kX3VQYa6+rCs/GewdTSqsZ
 e54ugu9bz0K+dAT2Nr768itHrCeTzucPr+8Cmo0qkMixylMYpZSXcJiyH/rciMgeSWd8hDIGw48
 XiFq9lHPLxofvPTsS8RuioCc0WI4TIefC20CXWpVXaobHLmE+BWmGnA0chYwKLdtQrKP8VQQaw0
 YxrPmWng1rck/WbghXaB85beU95AxJzCW8SPAlpiCPrcuKUcQYA=
X-Received: by 2002:a05:600c:4e94:b0:497:ff73:68d5 with SMTP id
 5b1f17b1804b1-4994e6c5eafmr415203865e9.0.1786225985049; 
 Sat, 08 Aug 2026 14:53:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995ea2e038sm144108475e9.14.2026.08.08.14.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 14:53:04 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 21:53:02 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 40cfe5c6d64dcd4fb6cbe8dbd3268a21527e71a3
X-Gerrit-Comment-Date: Sat, 8 Aug 2026 21:53:02 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <745126b44dc27fc8a92978e16775aa15322a1778-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsoyd-0005E5-Ll
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
Content-Type: multipart/mixed; boundary="===============2702883398764805621=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2702883398764805621==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4pyQk+7uXyk="; charset=UTF-8

--4pyQk+7uXyk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1727?usp=3Demail )

Change subject: Add lookup of multi session b=
y session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 26:

(4 comments)

File src/openvpn/multi=2Eh:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/d55f5112_31eb2707?usp=3Demail :
P=
S26, Line 138:     /** If this is multi_instance is hashed in the sid looku=
p table the session
> Remove the first "is" and the second "session id"
Don=
e


File src/openvpn/multi=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1727/comment/de3e6230_c5a2a5a0?usp=3Demail :
PS26, Line 431:             &&=
 dco_enabled(&mi->context=2Eoptions))
> is this an intended change or a deb=
ugging left-over?
I think that is a leftover of some of the many assym peer=
 id back and forth that accidentially ended up in this patch=2E I remove th=
at change=2E


File src/openvpn/sid_hash=2Eh:

http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1727/comment/32b92473_dd418a1a?usp=3Demail :
PS26, Line 23:  =
*  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
> old head=
er
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/a7038ae0_6=
4e00167?usp=3Demail :
PS26, Line 61:     struct hash_element *he_sid =3D ha=
sh_lookup_fast(m->sid_hash, sid_bucket, sid, sid_hv);
> should use `multi_h=
ash_sid_lookup()`
It looks like that but that does not actually work=2E The=
 function hash_remove_fast later the function requires sid_bucket and multi=
_hash_sid_lookup does not actually return that=2E



-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Ge=
rrit-Change-Number: 1727
Gerrit-PatchSet: 26
Gerrit-Owner: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: S=
at, 08 Aug 2026 21:53:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: N=
o
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--4pyQk+7uXyk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>4 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/multi=2Eh:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/=
comment/d55f5112_31eb2707?usp=3Demail">Patch Set #26, Line 138:</a> <code s=
tyle=3D"font-family:monospace,monospace">    /** If this is multi_instance =
is hashed in the sid lookup table the session</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Remove =
the first &quot;is&quot; and the second &quot;session id&quot;</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sr=
c/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/de3e6230_c5a=
2a5a0?usp=3Demail">Patch Set #26, Line 431:</a> <code style=3D"font-family:=
monospace,monospace">            &amp;&amp; dco_enabled(&amp;mi-&gt;context=
=2Eoptions))</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">is this an intended change or a debuggin=
g left-over?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">I think that is a leftover of some of the man=
y assym peer id back and forth that accidentially ended up in this patch=2E=
 I remove that change=2E</p></li></ul></li><li style=3D"margin: 0; padding:=
 0;"><p>File src/openvpn/sid_hash=2Eh:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/co=
mment/32b92473_dd418a1a?usp=3Demail">Patch Set #26, Line 23:</a> <code styl=
e=3D"font-family:monospace,monospace"> *  51 Franklin Street, Fifth Floor, =
Boston, MA 02110-1301 USA=2E</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">old header</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
727/comment/a7038ae0_64e00167?usp=3Demail">Patch Set #26, Line 61:</a> <cod=
e style=3D"font-family:monospace,monospace">    struct hash_element *he_sid=
 =3D hash_lookup_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv);</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">should use `multi_hash_sid_lookup()`</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">It looks l=
ike that but that does not actually work=2E The function hash_remove_fast l=
ater the function requires sid_bucket and multi_hash_sid_lookup does not ac=
tually return that=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59ecd1=
19331b198792ad1379bec8600211651b </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Sat, 08 Aug 2026 21:53:02 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--4pyQk+7uXyk=--


--===============2702883398764805621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2702883398764805621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2702883398764805621==--

