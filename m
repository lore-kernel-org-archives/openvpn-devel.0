Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C0AC5DF7F
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=NWVjR/S8DifT/mCZO3D6LKYDop38tpHHB+7Jt/RAcc4=; b=B3uUyjU3mPQmB/
	5kRYNUo7WiawS1Z0k1IzQg6v0CceN2AwXqQYtN10/rntAOizIrvKUV1kdtRI97+vPvo2x01p87HUV
	7epPNVAMeZJHLRhxvHAgHoaMnFP7VeH0/l+MiGS2pLEQS0StttMTuMFEk2shYzJ2FL7foC46PeMok
	pO0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvw9A-0001Pr-Hn;
	Mon, 17 Aug 2026 12:08:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvw99-0001Pi-1S
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:08:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k7r9jV/jKOt0YhDS/J0KBDQ6NjqG1snXTZzwf3pWJho=; b=ATbVSZWoPplvYQrfXrkDkRcvka
 0K0LwOoyO0reeYFYLFU2uJa/jr8xC1uc88TM3eEdgLUAEHE57skDOYt6o5j7gDIB+osjJoCg2W6c6
 I83/i2XNYjRnKSsD868bsOo6QkJWyHSO0yMBcAhcLtjX87iY0Kyspf3/Fw9lufdgXl4E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k7r9jV/jKOt0YhDS/J0KBDQ6NjqG1snXTZzwf3pWJho=; b=E
 jaFsNO/LzQmd8zxKGWBOUNPNsx+QAl79kKIRL5rKqSSxDOAz34NR56XAzWyCepBGR+frgPZnZ2t33
 63qet05eXIxCinkoHAg4kX99BAJhiDT9730dwp+DcNV4it6nEO4Oj2UPovIZ/xjeoMh4xL2lJcgY2
 zUYyNlJF0k+hdE40=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvw99-0001pY-Du for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:08:52 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so25414325e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786968525; x=1787573325; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k7r9jV/jKOt0YhDS/J0KBDQ6NjqG1snXTZzwf3pWJho=;
 b=ITAWjSB1R90METyp5IThV9GsDdlu7qKRWHWC7mXQ3wjtAtVGcDB4SCzDV4PAOGJ31+
 4NigktRdV3Gfq3dLjdUa+9X1S31RTma7be1G9muqMQ9j21qmPW8j72Qs2VIzoX2kDb5Q
 5UdL55HnzVCZo8pZ4ghT+eI3QnUCY5Az7u4BkKSdDZYDkR9dUHOfwvzs+1cbi1eYFo1s
 oUQqBn9mCrdUEbF+S6D5LVrHLlWu50YnFejmYuomtzeOfQRYb1GxYQganlUn7IiiOQLV
 4bhMU3ObdPcYbCpo753WE5Os7SfMJ4bvfiz5wGNKF0m9RIBM0izeQHcKek+wlVR/B4R5
 bEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786968525; x=1787573325;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k7r9jV/jKOt0YhDS/J0KBDQ6NjqG1snXTZzwf3pWJho=;
 b=s9AMjmQFr/QYhN5x+BlqV23s+/RTwHZI5UEw8kjw/vBIGZcFJD71Q5ANhioWfeMiaJ
 16EH/AaNWaylD+/nfPqNPDS17FUc2VMlDOcgGvv8433cec0LHmWcw8T4kJhyV17Z1n+k
 rxPFZabt+n1w6aRBI4aBqViO/JLZJvDKwoPe6mix0En95bTW3U6V6RIebjdxOGPFK8zk
 sdOlgQaqRbdrv0KMAkN9vC7g05y6RKCFGZoBEFA//9EFd9M/ZssRDr/EYwthG9nL4SfB
 5PdbJtHu2hD7t55Gjo59+VoOlVPmd7F0iKBWqtlgvDoiTfVX0LGJvA277MJX9LDD4jn+
 Oi5A==
X-Gm-Message-State: AOJu0YywXzNzPnMjO69nEIYv5LXDiaHFvd+nGtza4vdSpHq7JCqcTPvm
 6gax+P8vr8lebSROxUQXr+WH0169+kDVSvoRQkNpghk+h1DeJqNqwqNRJl/DopDXZgRfc65lNH8
 XIJtNLUg8fhlfZIpnS7SgOowXHiTjeeighYs0AI3Y2DscYrzp1l341NMrKcKNGtpj7T8r
X-Gm-Gg: AR+sD12WmtbcRFEX2HIAqCm0LwjWZmtX9TtelZesFmDfe3Mt9Av0qNg5vY31k5Jw7Yj
 Ow/KX8sxq2msgH18RJgMVZYzcMAljc1Md4gqEI7kkmnocKOPqk/RvrJ1Rhoz6iFoBNVOtiYenrf
 05LvgHHeAEWKGmaipnYTcRScG2hoUecU5jfnuZr4pBL8b7yuv2a473RF+MkXcAp+LsSRnn2MGQq
 9Yz6ArtDbHaZesvdoqqsSFqL6wjJZ0twW6Mcdmhujd7i/SHkcQDHnlJ/Vt+Cw1Q0QOh1ZD7NQRu
 E+AhEuvjcaQeIEePrgclm6ADCSgXb4+II4Pg8Lm0ICNGmtCzC/Khol7jdlq/8k0+uT2KuSQNxa5
 cOCiYz+18gRc+xZ/8Ohw+ivQjX+f3gx30FPP4Go54QaH81s/XkRY1JIF0MqTb5hJH8tt7F0yJJa
 otPC/hHzkZyjlpML4b1/IYFaEfCBeL6tliE/cQHWPH53QHxjMBqifHa5hYn5l7Yd5g/G3n0LP39
 XA+/RIRT6vNUnumuJdQoip28hFgjGK55vgSdTXDTc9nqbBWYWZ5CAV/Pql7pVECncamrZImSOZs
 gao0lejqm/AM5L8JoAODblyqhxIk4GuNUIJh5ntEJA8OcBRcGu4=
X-Received: by 2002:a05:600c:3796:b0:495:4811:7998 with SMTP id
 5b1f17b1804b1-49987993e08mr318113855e9.17.1786968525293; 
 Mon, 17 Aug 2026 05:08:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d0876b8sm50125745e9.8.2026.08.17.05.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:08:44 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:08:43 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I450568c0307a6372506d115cb389d172472140d4
X-Gerrit-Change-Number: 1845
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1845?usp=email>
X-Gerrit-Commit: 67d8b92b41b94b3e838a692e67a6139416e9952c
References: <gerrit.1786968495000.I450568c0307a6372506d115cb389d172472140d4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTY4NDk1MDAwLkk0NTA1NjhjMDMwN2E2MzcyNTA2ZDExNWNiMzg5ZDE3MjQ3MjE0MGQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e0a3504159f226543e93afc83b17b0e249d92a81-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvw99-0001pY-Du
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: buffer: Remove some
 useless casts on BLAST returns
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0784809398730490482=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0784809398730490482==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VXTf6/1UWg4="; charset=UTF-8

--VXTf6/1UWg4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1845?usp=3Demail

to review the following change=2E


Chang=
e subject: buffer: Remove some useless casts on BLAST returns
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Remove some usele=
ss casts on BLAST returns

We can compare to '\0' without having to do cast=
ing=2E

Change-Id: I450568c0307a6372506d115cb389d172472140d4
Signed-off-by:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/buffer=2Ec
1=
 file changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/45/1845/1

diff --git a/src/ope=
nvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index bf38c68=2E=2E87d3094 100644
=
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -500,7 +500,7 =
@@
 void
 buf_null_terminate(struct buffer *buf)
 {
-    const char *last =
=3D (char *)BLAST(buf);
+    const uint8_t *last =3D BLAST(buf);
     if (l=
ast && *last =3D=3D '\0') /* already terminated? */
     {
         return;=

@@ -523,12 +523,12 @@
 {
     while (true)
     {
-        const char *las=
t =3D (char *)BLAST(buf);
+        const uint8_t *last =3D BLAST(buf);
    =
     if (!last)
         {
             break;
         }
-        if (char=
_class((unsigned char)*last, CC_CRLF | CC_NULL))
+        if (char_class(*l=
ast, CC_CRLF | CC_NULL))
         {
             if (!buf_inc_len(buf, -1))=

             {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1845?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I45=
0568c0307a6372506d115cb389d172472140d4
Gerrit-Change-Number: 1845
Gerrit-Pa=
tchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openv=
pn@rfc2549=2Eorg>

--VXTf6/1UWg4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1845?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">buffer: Remove some useless casts on BLAST returns<br><br>We can compa=
re to &#39;\0&#39; without having to do casting=2E<br><br>Change-Id: I45056=
8c0307a6372506d115cb389d172472140d4<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>1 file c=
hanged, 3 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/45/1845/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><spa=
n>index bf38c68=2E=2E87d3094 100644</span><br><span>--- a/src/openvpn/buffe=
r=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -500,=
7 +500,7 @@</span><br><span> void</span><br><span> buf_null_terminate(struc=
t buffer *buf)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    const char *last =3D (char *)BLAST(buf);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *last =3D BLAST(buf)=
;</span><br><span>     if (last &amp;&amp; *last =3D=3D &#39;\0&#39;) /* al=
ready terminated? */</span><br><span>     {</span><br><span>         return=
;</span><br><span>@@ -523,12 +523,12 @@</span><br><span> {</span><br><span>=
     while (true)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        const char *last =3D (char *)BLAST(buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const uint8_t *last=
 =3D BLAST(buf);</span><br><span>         if (!last)</span><br><span>      =
   {</span><br><span>             break;</span><br><span>         }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (char_class((unsig=
ned char)*last, CC_CRLF | CC_NULL))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (char_class(*last, CC_CRLF | CC_NULL))</span><br=
><span>         {</span><br><span>             if (!buf_inc_len(buf, -1))</=
span><br><span>             {</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1845?usp=3Demail=
">change 1845</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/184=
5?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I450568c0307a6372506d115cb389d172472140d4 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1845 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--VXTf6/1UWg4=--


--===============0784809398730490482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0784809398730490482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0784809398730490482==--

