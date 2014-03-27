Message-ID: <53344392.5040505@...1847...>
Date: Thu, 27 Mar 2014 16:28:18 +0100
From: =?ISO-8859-1?Q?Andr=E9_Valentin?= <avalentin@...1847...>
MIME-Version: 1.0
References: <CAGyAFMXhPTamN5tZYr92=re8Bhxky=priWS8UhCU3E_p2D8-mQ@...278...>
	<CAGyAFMV6kZzTFwdp21n8GTNa-fbPx_S-TpYjpiC+R862WoMhAA@...278...>
In-Reply-To: <CAGyAFMV6kZzTFwdp21n8GTNa-fbPx_S-TpYjpiC+R862WoMhAA@...278...>
Content-Type: multipart/alternative;
	boundary="------------070707030208040200070202"
Subject: Re: [Openvpn-devel] session-id implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070707030208040200070202
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi!

Great stuff, can't wait to use it!

Andr=E9

On 27.03.2014 09:57, Lev Stipakov wrote:
> Hi,
>
> Same patch with added NULL check in push.c:308. Turns out that
> peer_info might be NULL.
>
> -Lev
>
> On Wed, Mar 26, 2014 at 10:52 AM, Lev Stipakov <lstipakov@...277...> wrot=
e:
>> Hello,
>>
>> Despite that implementation of session-id has already been discussed,
>> I would like to propose an alternative approach.
>>
>> I suggest to use an array of multi_instance objects and session-id as
>> an item's index in that array. Why I think it is a good idea?
>>
>> 1) We could utilize less bytes for session-id, since array's max
>> length would be equal to max_clients. 3 bytes for a max of 2**24
>> clients, no need to swap one byte to the end of packet.
>>
>> [op][s1][s2][s3][data]
>>
>> 2) Lookup in array is faster than lookup by 8-byte session-id in
>> hashtable and happens with constant speed.
>>
>> 3) Proof of concept is attached!
>>
>> I have tested it with openvpn master branch (server) and ics-openvpn
>> (android) - merged without any conflicts and works nicely. Of course
>> it supports also peers without session-id support.
>>
>> This patch solves 2 issues for mobile clients:
>>
>> 1) UDP NAT timeout. After, say, 30, seconds router might close UDP
>> socket and new packet from client to VPN server originates from
>> different port. Lookup by peer address fails and packet got dropped.
>> Currently this is solved by small keep-alive interval, which drains
>> battery. With new implementation it is not an issue anymore since
>> lookup is done by session-id, therefore keep-alive interval can be
>> increased.
>>
>> 2) Transition between networks (for example WiFi->3G). Without
>> session-id client got disconnected. With this patch and
>> http://code.google.com/p/ics-openvpn/source/detail?r=3Dbc9f3f448b9a4d95c=
999d3e582987840ba1e0fbf
>> transition happens seamlessly.
>>
>> I would love to hear any critics / comments!
>>
>> --
>> -Lev
>
>
>
>
> -------------------------------------------------------------------------=
-----
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------070707030208040200070202
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi!<br>
      <br>
      Great stuff, can't wait to use it!<br>
      <br>
      Andr&eacute;<br>
      <br>
      On 27.03.2014 09:57, Lev Stipakov wrote:<br>
    </div>
    <blockquote
cite="mid:CAGyAFMV6kZzTFwdp21n8GTNa-fbPx_S-TpYjpiC+R862WoMhAA@...278..."
      type="cite">
      <pre wrap="">Hi,

Same patch with added NULL check in push.c:308. Turns out that
peer_info might be NULL.

-Lev

On Wed, Mar 26, 2014 at 10:52 AM, Lev Stipakov <a class="moz-txt-link-rfc2396E" href="mailto:lstipakov@...277...">&lt;lstipakov@...277...&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Hello,

Despite that implementation of session-id has already been discussed,
I would like to propose an alternative approach.

I suggest to use an array of multi_instance objects and session-id as
an item's index in that array. Why I think it is a good idea?

1) We could utilize less bytes for session-id, since array's max
length would be equal to max_clients. 3 bytes for a max of 2**24
clients, no need to swap one byte to the end of packet.

[op][s1][s2][s3][data]

2) Lookup in array is faster than lookup by 8-byte session-id in
hashtable and happens with constant speed.

3) Proof of concept is attached!

I have tested it with openvpn master branch (server) and ics-openvpn
(android) - merged without any conflicts and works nicely. Of course
it supports also peers without session-id support.

This patch solves 2 issues for mobile clients:

1) UDP NAT timeout. After, say, 30, seconds router might close UDP
socket and new packet from client to VPN server originates from
different port. Lookup by peer address fails and packet got dropped.
Currently this is solved by small keep-alive interval, which drains
battery. With new implementation it is not an issue anymore since
lookup is done by session-id, therefore keep-alive interval can be
increased.

2) Transition between networks (for example WiFi-&gt;3G). Without
session-id client got disconnected. With this patch and
<a class="moz-txt-link-freetext" href="http://code.google.com/p/ics-openvpn/source/detail?r=bc9f3f448b9a4d95c999d3e582987840ba1e0fbf">http://code.google.com/p/ics-openvpn/source/detail?r=bc9f3f448b9a4d95c999d3e582987840ba1e0fbf</a>
transition happens seamlessly.

I would love to hear any critics / comments!

--
-Lev
</pre>
      </blockquote>
      <pre wrap="">


</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">------------------------------------------------------------------------------
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------070707030208040200070202--

