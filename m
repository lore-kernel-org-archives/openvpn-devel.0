References: <1445277979-21591-1-git-send-email-gert@...1296...>
	<5625FF23.70203@...1400...>
	<20151020212827.GN22054@...1296...>
	<5626C540.2080907@...1114...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56274788.6060801@...1227...>
Date: Wed, 21 Oct 2015 10:06:32 +0200
MIME-Version: 1.0
In-Reply-To: <5626C540.2080907@...1114...>
Content-Type: multipart/alternative;
	boundary="------------000108020501010502020004"
Subject: Re: [Openvpn-devel] [PATCH] Add option --push-suppress-ipv6 to stop
 sending IPv6 info to clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

This is a multi-part message in MIME format.
--------------000108020501010502020004
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit



Am 21.10.15 um 00:50 schrieb David Sommerseth:
>> >  --push-filter ifconfig-ipv6 tun-ipv6 route-ipv6
>> > 
>> > which would do exactly what the current patch did, but is much more flexible
>> > depending on what exactly needs to be worked around with *this* client...
>> > 
>> > (There's a trac ticket about "--push-reset", which we might resolve with
>> > this as well :-) )
> I agree with the intention.  Just not sure 'filter' is a clever word.  As it
> can be understood both as "remove these options" or "only include these
> options".  Both interpretations are results of a filter.
push-suppress?

Arne

--------------000108020501010502020004
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <br>
    <div class="moz-cite-prefix">Am 21.10.15 um 00:50 schrieb David
      Sommerseth:<br>
    </div>
    <blockquote cite="mid:5626C540.2080907@...1114..." type="cite">
      <blockquote type="cite" style="color: #000000;">
        <pre wrap=""><span class="moz-txt-citetags">&gt; </span> --push-filter ifconfig-ipv6 tun-ipv6 route-ipv6
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>which would do exactly what the current patch did, but is much more flexible
<span class="moz-txt-citetags">&gt; </span>depending on what exactly needs to be worked around with <b class="moz-txt-star"><span class="moz-txt-tag">*</span>this<span class="moz-txt-tag">*</span></b> client...
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>(There's a trac ticket about "--push-reset", which we might resolve with
<span class="moz-txt-citetags">&gt; </span>this as well <span class="moz-smiley-s1" title=":-)"><span>:-)</span></span> )
</pre>
      </blockquote>
      <pre wrap="">I agree with the intention.  Just not sure 'filter' is a clever word.  As it
can be understood both as "remove these options" or "only include these
options".  Both interpretations are results of a filter.
</pre>
    </blockquote>
    push-suppress?<br>
    <br>
    Arne<br>
  </body>
</html>

--------------000108020501010502020004--

