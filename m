Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06253CA5FFC
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9EINDZgU38BBYtJQKJ5ukblCiO3Lj8qlzME41odK5DY=; b=MD+bln1+oMpP6idij0l0D5vELZ
	n4METcJbEpb/UrKNQrjLCuQxv+8g9edf44Q6uyiXXksMx+MlpkTbFYYgk8qCSPMkoN6AoqiPI0TpM
	e9CXReYJu8wkAvicPqrAMIO9fSiracrqFGuGrFfVtCJR0FAF4u54D9494sWRgIz3IGwI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xERwE-0002iS-08;
	Wed, 07 Oct 2026 13:44:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1xERvy-0002hs-Sz
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 13:43:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rwzg+sG56eK7DLj3Xj1IepXMhZRnHA0pxIVGXXLEwPw=; b=FnODdTRcJwR2iKeLb4B6jafnVU
 bsa7CuUm5CSCaZO2BXTT0H2EF4U8xkO3JbvY4MnVDyCI4qHjf3OBz+PLQvtUXjIcZBNV74r46Fgla
 Z55/UFvJHwMRzjSl63sMy36aNty73Zf84UC50ePKwJcqfPzmCRaXR+FLMLT3lw0D53j8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Rwzg+sG56eK7DLj3Xj1IepXMhZRnHA0pxIVGXXLEwPw=; b=F
 /9pmvc3ujf3jPg/GBjlJdRJFCOo0XCIHi3DynN4qlJXeGTwy74FCl50jvGnNjhgx2CogEbvy2R5GO
 w6Ze7sUBA6tQQGD8jnrcZ3bDaf1G7DTN1ls2n+dCUEwJkT0RMTj8UtcHqJfGfT8AZvvgQX2dheP2i
 I3lpZO+TGEUM7tH0=;
Received: from mail-dl1-f47.google.com ([74.125.82.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xERvu-0003pT-MG for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 13:43:48 +0000
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-150f88d22aeso140599c88.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1791380621; x=1791985421; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Rwzg+sG56eK7DLj3Xj1IepXMhZRnHA0pxIVGXXLEwPw=;
 b=paSiYHh0Lgg7JIYOPkVFic8KGQ5ycRomB6ZjiCieaQx+ENOkHtozH5bxaMWtfW6W+G
 i8eluTPY6p4vCnnTQnsUIfzZklcdcQVyXynudVRM/mIkB8qbY4b3VYltX+ALDdPvTVSB
 Y8xF37AeNzcQIx1xh/u07y4s7H4dtOB+UrZdRb4KUXQ6QnmqVTlGOohc0Ob1ExFx/4Zh
 vKMgeYlYY6dHlDBXhIhRpyocxp4y/O52HyPNQ0Fz0E6suzTsY0nQcDP+oKvqlxnMvMES
 VgUi42MTWdclCXV7WXT8TG32j1jRs/1XbN9BTuJxs3T74TjaKxXo2VOvyvCKUmFdyMsw
 fmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791380621; x=1791985421;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rwzg+sG56eK7DLj3Xj1IepXMhZRnHA0pxIVGXXLEwPw=;
 b=SSznUXDCnJDDpvwV7tM0Pc98HI+8Syvbz6L9AFwsQzx3qHJvgYh23emJgRD8cMlt/X
 071RD2jbnZpDRv0RZSvUPmVglxZ/LmQHJm8YCCXU2ksLmJ8hUMg0YP4SFvQKzrZVpuZE
 1UQaVilz9hOdxdtqXf1s6Vf3l/yLz1LP5EQ9TJX9EODzj/oJQxUb2eVF/rxbuO8uovjc
 vDcfz99O0jpLFYg+52N1f7mDL9a4wlR8Sh4VKarFLnCLKYPtmMg4tsxts8EI8rB5AF1D
 SMpVKXlp2l4g/dZaruYzISW6DxVOUerj7JHrgLqdCiLBgHX+85HpYH9EN4g4+DuKOT8I
 WDiA==
X-Gm-Message-State: AFuF++nZix5etcJARpQJOh7jdNXFYz1fCdkPHRyZG8aYD1Bng4M4+jFZ
 P6UQLFRPOXMeyrULut4ql+xY1ceyaT0q3NfVR55a5Q9LhQlPUFmzu+1DIPEwx8UYgboiO4FuY5H
 2h6/yNbj1G9U5Spw0iJAc9GE1SIOUc9Yd2RFdAXhWza4mGscKpBOt2acWzI2iKpqDuPvRaqpiEM
 vEv4MPKK/F
X-Gm-Gg: AYBFou0Rqb7Cu4r4k8ISFBnl9XMsO7qRSkmYb3HzyTXMEfn4LGeV5vcEiRjqdp9EDtT
 n300NQ9ijIVp/9HL5A1rsGRWJ14458wMPOGuD60S1amvOcOxtFBV/oq3MHNGcbRRqIkuwzJP8pv
 7+9eltxSRVAkT8ayORkXTSaC59eVQk9ly0uO2oqo4LIxZbOvuMDSzTfEW7g/kNXYbVdElnqwJZs
 Gw1XIo7RuyCeIUPkSENoXr2oelNtI1xzAQyPaRJAkXs6NtAh6oFnCyqxwUH475LJSydXpUqKR9l
 SdtBnuiXiBMIsTeiw9ioiu8M87HRFNePu13Zq+devA0OKsKkjJ1l9t140Lhk1OtwTujOGLUPDef
 s9aJxol2xQOxaHOlCym+oGGeHfTVWwFdqFJ0xJ/aHFEuze0YBujKCb+ows1aEBAHPSE8twzsD2W
 U/JQLwZSgFbkuwuaGR6gyWi6IQ+N5tg3C5RcIzBSlabsscWsOA3t9MQ0G8equ4fws5I2XrazhIn
 asHp/10HCMHaXFfhO4eXSsx1g6R4x80AuvnrhIDiI8=
X-Received: by 2002:a17:90b:134b:b0:3a7:933a:3195 with SMTP id
 98e67ed59e1d1-3a8a072a7d1mr1900474a91.7.1791377241115; 
 Wed, 07 Oct 2026 05:47:21 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4fc2:28e0:fa0d:e1b4:c8df:340e?
 ([2001:ee0:4fc2:28e0:fa0d:e1b4:c8df:340e])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a89b71eedesm4673986a91.15.2026.10.07.05.47.19
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 05:47:20 -0700 (PDT)
Message-ID: <994fb186-bec3-46ec-aeed-6102ba745402@openvpn.com>
Date: Wed, 7 Oct 2026 19:47:17 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1xERvu-0003pT-MG
Subject: [Openvpn-devel]  IRC community meeting summary
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
From: Johan Draaisma via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Johan Draaisma <johan@openvpn.com>
Content-Type: multipart/mixed; boundary="===============5783024982595206798=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============5783024982595206798==
Content-Type: multipart/alternative;
 boundary="------------4RtNb41AoIPDuS4Ybu3n9u0V"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4RtNb41AoIPDuS4Ybu3n9u0V
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 7 October 2026:

  * *Updated: 2.7.x release*
    Originally 2.7.8 was planned for last week, but a last moment fix
    for Windows DCO driver made us decide to postpone till today.
    2.7.8 with the Windows DCO driver update will go out today.
    Version 2.7.9 is now planned for 4 November.
  * *Updated: community meetup 2026*
    Coordination is currently taking place here:
    https://community.openvpn.net/Meetups/2026-Paderborn
    The date is around 17 and 18 October, location in Paderborn, Germany.
    The t-shirt design was completed and the shirts have been ordered
    and will be delivered to Paderborn directly.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------4RtNb41AoIPDuS4Ybu3n9u0V
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 7 October 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
          2.7.x release</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        Originally 2.7.8 was planned for last week, but a last moment
        fix for Windows DCO driver made us decide to postpone till
        today.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        2.7.8 with the Windows DCO driver update will go out today.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        Version 2.7.9 is now planned for 4 November.</li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
          community meetup 2026</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        Coordination is currently taking place here: <a
          href="https://community.openvpn.net/Meetups/2026-Paderborn"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
          class="moz-txt-link-freetext">https://community.openvpn.net/Meetups/2026-Paderborn</a><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        The date is around 17 and 18 October, location in Paderborn,
        Germany.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        The t-shirt design was completed and the shirts have been
        ordered and will be delivered to Paderborn directly.</li>
    </ul>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
    </ul>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------4RtNb41AoIPDuS4Ybu3n9u0V--


--===============5783024982595206798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5783024982595206798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5783024982595206798==--

