Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82017CA5FB1
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zK0Z67sWyYnacU8aYnUfEsfsMRvt7MoVlUiaTdw/Xrk=; b=MP5ECDj9aC9DD14lWRpcvWefeK
	cKtsfbosle0sZv52WN9A9SdWq8oNIkf/k6alLhPojjyS3nQAbneP63VHadsjcmQvCkqAk04sVOplq
	hMCbr/8i+ubEA3q94hivVp49PtFLfjA/3tmDJaSexUKsXEeeki39DusfdvQMDmGyv+EE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBtdv-00049L-UB;
	Wed, 30 Sep 2026 12:42:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1xBtdu-00049E-8D
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 12:42:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gtUg3CxjOiwOif6E8angjofKd5h3NQ2Ho4nb3bqqHwE=; b=IVcNxrEd1tUFrsN+ZP9YvGDVtH
 wyGc9dt5iATpif0BtpbshzlkaxvCybP/9hHAfPzRD2DSsnar0+vHshQKEZlZxlD3+BnlnRsmtl+pE
 480mOM9XnlNQeY1IgVXLT1DmMCH78z8q+3Da1tNLBUqd1eEoXGKWKmduroivxcijhuUg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gtUg3CxjOiwOif6E8angjofKd5h3NQ2Ho4nb3bqqHwE=; b=K
 fr5WzcSnIbKhM5nOdSHHwJUniZS95sCTL78Hleei5o2Rr4DUV+MXGS6Uy6CopR5kk8bENFjFCPnzG
 i4anKmxWAuic6Nc95DjvCqoV1F3bZiEsUOfnHe7/rvybrR42fbUGlP8zidwVE68PyTAU7ImXv5anw
 gov+i2RhAS1t/cZ8=;
Received: from mail-qk2-f39.google.com ([74.125.230.231])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBtdt-000477-DB for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 12:42:38 +0000
Received: by mail-qk2-f39.google.com with SMTP id
 d75a77b69052e-533342a38ebso46670271cf.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1790772151; x=1791376951; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gtUg3CxjOiwOif6E8angjofKd5h3NQ2Ho4nb3bqqHwE=;
 b=RsT9YzT4neumpWC3kf1hIMAmShrW6Kjb6YEuwx3CB79HdNGDhJzJhA+vusf/iygNYX
 yI28T26Y5MSndpHu8lQ+Pudtf+qjxM+KzPZ9u1X8K4mXVdnWfK5yziDcbtv2JeJC4CFu
 XVGGkqharI7L4hxBac0+kdc2YW7zrYxnMLBYgAB8SL3rmJlvS77lExEadWQGp2RQTequ
 CH9skpX95UihDyepJcm/3gGzkum1JrOAmsZbov3xI28jg5jgj32m9OuCxfGww9mdtQIb
 Wu16lb1Uk2c9ahsuPmqcgDi3VkVcDVWjU4whB8kKvnbqCywXTWksYM8UO78hLS4WWSFW
 2gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790772151; x=1791376951;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gtUg3CxjOiwOif6E8angjofKd5h3NQ2Ho4nb3bqqHwE=;
 b=EDHeUxWgQuVDFyzd2zS+6SO3FEQ5eadzqijCEwVL1tU4/ZpVPLD5CXfgSdVuBpxSSx
 RTDJvPaLIsu6EMG5y3fx4W+dY4FLR2ENpmnBzSA9fvkEXiC/TeOQ/ISCP7UYVg06TAPT
 +bbIKXykzNe9HxLF+bJLMJmv6TA1dQM4WMoItHgVFoEzCx3BFGBMq+3HCe0fM8ysH/ds
 BH/s5Hss5goaTXBK2FcBJtRkXa2USP3Rjfgg2g508jPzYk09tF3td1RzASh1ED3lOBCU
 OGxcnA2L2orUhEhSIxkSZbYlsyUsol61rIz6sZ+zLDJYimH1KGgDLgNYK/GoXKMusLZY
 26BQ==
X-Gm-Message-State: AFuF++nAIoHPMi3NbLrjrVw98OoSDk8/PyyL0JDJfz12whP6K5YSfZxg
 j98QcQ8rBo3a3IPiatX/9QdfDm9N9LjpGYFGjCXN2CCxVbPmL9+06oLtraM1VLcspZZZBXUutq2
 L+1XLECd1zsBj4a/8XUAOBvhdFr7hXjHHdFqYt7kt08u5qroBX7WvzVYK1EVha0vREwCxjyQSEv
 TbTogIslyo
X-Gm-Gg: AYBFou1B7C8Ao97q6bDTFjPCPsYlptR0gIsBQljcLoGcPZSj7zwxRGi7AvjjRtDa4sW
 neMb8KU9O1PruLuS7hKCP23jfe4SNLOq1bVqE6Kjvxd/2IuADG36zfLCkGSPH7YxKiUDk8KpCuI
 i/07Fw5SLLAFpNkCWUtrR3GB0D6/rt4M0Zy9b3p7IEsaGW+fTjvfdj1iZLmPLmHCSoaETMULE3b
 ZTwVOEnzt02+N6ne9wuKl/s3n+TU40GTRlTPizmmFYq3DxJWMcFXzykSxgRiViSK7md6Tns7jZa
 8WuGNUJx6PVGG5jPU5vsKw53qFz85fjbWIuqBbSI9dTZlrVIyUYRQzslK4Sdlio0teWGdqafcZP
 HC34LRDfDS1+LrtV2oAPFh3Nd0nHlADXXQ+6HVVpWULRQSC9GHaK4ic7+o/UUv/P8ecbSw9O8XW
 P/wyXLiCt5bffYZSqiGucISDuujyuywb0kiFllTfb6pONxAAVDO6pfOqE8lK5ZtKP2Bxxl2e3EW
 z31SGu9LKxxyXldi1E6fA8FxG5U1cDw3AFMzcrRhN3HZfBf1fEydg==
X-Received: by 2002:a17:90b:55c4:b0:39e:6c69:34da with SMTP id
 98e67ed59e1d1-3a4d1db1ed0mr1117165a91.62.1790771655963; 
 Wed, 30 Sep 2026 05:34:15 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4fc2:28e0:853b:2c19:bfad:1832?
 ([2001:ee0:4fc2:28e0:853b:2c19:bfad:1832])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4ce16ac10sm3159588a91.8.2026.09.30.05.34.14
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 05:34:15 -0700 (PDT)
Message-ID: <c72d71f0-67da-496d-96fa-cf76dac03893@openvpn.com>
Date: Wed, 30 Sep 2026 19:34:11 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1xBtdt-000477-DB
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
Content-Type: multipart/mixed; boundary="===============4146727072619567668=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============4146727072619567668==
Content-Type: multipart/alternative;
 boundary="------------sGGR11taQwLOXUVC3EdTj6C1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------sGGR11taQwLOXUVC3EdTj6C1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 30 September 2026:

  *

    *New: gerrit login via oauth*
    uddr35 raised the topic that he's migrating profiles in gerrit to be
    compatible with the github oauth login method.
    The switch to github login is expected to occur sometime this week.
    If anyone has issues logging in to gerrit, reach uddr35 on IRC.

  *

    *Updated: 2.7.x release*
    A few more security fixes are coming in 2.7.8, and this is planned
    for October 1st.

  *

    *Updated: 2.6.x release*
    2.6.23 was released last week, it contains a number of small
    security fixes and bug fixes.

  * *Updated: community meetup 2026*
    Coordination is currently taking place
    here:https://community.openvpn.net/Meetups/2026-Paderborn
    The date is around 17 and 18 October, location in Paderborn, Germany.
    For the t-shirt, novaflash will put something together and throw it
    in community signal chat tomorrow.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------sGGR11taQwLOXUVC3EdTj6C1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 30 September 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            gerrit login via oauth</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          uddr35 raised the topic that he's migrating profiles in gerrit
          to be compatible with the github oauth login method.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          The switch to github login is expected to occur sometime this
          week.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          If anyone has issues logging in to gerrit, reach uddr35 on
          IRC.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            2.7.x release</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          A few more security fixes are coming in 2.7.8, and this is
          planned for October 1st.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            2.6.x release</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          2.6.23 was released last week, it contains a number of small
          security fixes and bug fixes.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
          community meetup 2026</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        Coordination is currently taking place here:<span> </span><a
          href="https://community.openvpn.net/Meetups/2026-Paderborn"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
          class="moz-txt-link-freetext">https://community.openvpn.net/Meetups/2026-Paderborn</a><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        The date is around 17 and 18 October, location in Paderborn,
        Germany.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
        For the t-shirt, novaflash will put something together and throw
        it in community signal chat tomorrow.</li>
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

--------------sGGR11taQwLOXUVC3EdTj6C1--


--===============4146727072619567668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4146727072619567668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4146727072619567668==--

