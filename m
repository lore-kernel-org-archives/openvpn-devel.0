Content-Type: multipart/alternative;
 boundary="------------Sq2dNwzWRg56Zu8H2rGmZvkX"
Message-ID: <92cf0278-85b5-4563-93d4-7a814de2cc86@...2726...>
Date: Thu, 15 Feb 2024 20:50:43 +0100
MIME-Version: 1.0
References: <gerrit.1708012740000.I4b5e8357d872c920efdb64632e9bce72cebee202@...2715...>
 <a91d834e2d9f284b0278cf9940f50dd0a539f057-HTML@...2715...>
 <Zc45NJAyJyLoTRee@...1296...>
Content-Language: it
From: Gianmarco De Gregori <gianmarco@...2726...>
In-Reply-To: <Zc45NJAyJyLoTRee@...1296...>
Subject: Re: [Openvpn-devel] [S] Change in openvpn[master]: Minor fix to
 process_ip_header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net, frank@...2641...

This is a multi-part message in MIME format.
--------------Sq2dNwzWRg56Zu8H2rGmZvkX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Il 15/02/2024 17:17, Gert Doering ha scritto:
> Hi,
>
> On Thu, Feb 15, 2024 at 03:59:02PM +0000, its_Giaan (Code Review) wrote:
>>       if (buf->len > 0)
>>       {
>> -        /*
>> -         * The --passtos and --mssfix options require
>> -         * us to examine the IPv4 header.
>> -         */
>> -
>> -        if (flags & (PIP_MSSFIX
>> -#if PASSTOS_CAPABILITY
>> -                     | PIPV4_PASSTOS
>> -#endif
>> -                     | PIPV4_CLIENT_NAT
>> -                     ))
>> +        if (flags & PIP_OPT_MASK)
> NAK, as this is not the same thing.  PIP_OPT_MASK will also match on
> the IPv6 flags, which are not something we need to test for here (= if
> only an IPv6 flag is active, why should we enter this branch?).

I had the feeling that it was wrong in fact.

Thanks for your feedback.

Cheers

-- 
Gianmarco De Gregori

--------------Sq2dNwzWRg56Zu8H2rGmZvkX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi, <br>
    </p>
    <div class="moz-cite-prefix">Il 15/02/2024 17:17, Gert Doering ha
      scritto:<br>
    </div>
    <blockquote type="cite" cite="mid:Zc45NJAyJyLoTRee@...1296...">
      <pre class="moz-quote-pre" wrap="">Hi,

On Thu, Feb 15, 2024 at 03:59:02PM +0000, its_Giaan (Code Review) wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">     if (buf-&gt;len &gt; 0)
     {
-        /*
-         * The --passtos and --mssfix options require
-         * us to examine the IPv4 header.
-         */
-
-        if (flags &amp; (PIP_MSSFIX
-#if PASSTOS_CAPABILITY
-                     | PIPV4_PASSTOS
-#endif
-                     | PIPV4_CLIENT_NAT
-                     ))
+        if (flags &amp; PIP_OPT_MASK)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
NAK, as this is not the same thing.  PIP_OPT_MASK will also match on
the IPv6 flags, which are not something we need to test for here (= if
only an IPv6 flag is active, why should we enter this branch?).</pre>
    </blockquote>
    <p>I had the feeling that it was wrong in fact.</p>
    <p>Thanks for your feedback.</p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <p><span style="white-space: pre-wrap">Cheers
</span></p>
    <pre class="moz-signature" cols="72">-- 
Gianmarco De Gregori</pre>
  </body>
</html>

--------------Sq2dNwzWRg56Zu8H2rGmZvkX--

