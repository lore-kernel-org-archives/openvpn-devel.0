Message-ID: <50445995.30700@...1227...>
Date: Mon, 03 Sep 2012 09:17:41 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1343837470-3923-5-git-send-email-arne@...1227...>
	<1346654982-25059-1-git-send-email-arne@...1227...>
	<20120903070957.GL18296@...1296...>
In-Reply-To: <20120903070957.GL18296@...1296...>
Content-Type: multipart/alternative;
	boundary="------------010909050008070704030105"
Subject: Re: [Openvpn-devel] [PATCH] Simplify print_sockaddr_ex function,
 merge duplicate ipv4/ipv6 logic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010909050008070704030105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 03.09.12 09:09, schrieb Gert Doering:
> Hi,
>
> On Mon, Sep 03, 2012 at 08:49:42AM +0200, Arne Schwabe wrote:
>> Some BSD need the right salen, max(sizeof(v4),sizeof(v6)) does not
work. Since sa_len is not a member in sockaddr for Linux and Windows and
SA_LEN is no available on Darwin, NetBSD explicitly set salem
>
> "Something sneaked into your keyboard"...
>
>> + getnameinfo(&addr->addr.sa, sizeof (struct sockaddr_in6),
>> + buf, sizeof (buf), NULL, 0, NI_NUMERICHOST);
>
> ... this very much looks like v1 of the patch...? :-)
>
> Anyway, what about defining an openvpn_sa_len() macro that will either
> use SA_LEN() if it exists, or fall back to
>
> #define openvpn_sa_len(addr) ( addr->sa.sa_family == AF_INET?
sizeof(struct sockaddr_in) : sizeof(struct sockaddr_in6) )
>
> this will, of course, bite us when we implement IPv8, but should be fine
> for 2.3...

I will try to avoid this for now... I hope to convert openvpn to fully
using getnameinfo/getaddrinfo
one day so that we do not need these deep look into the sockaddr anymore.


> (Is there something magic in Autoconf to solve this? Must be a standard
> problem...)
>
>
I think most people don't deal with raw sockaddr structs. getaddrinfo
returns ai_addrlen.

Arne
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (Darwin)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBEWZUACgkQe8+cMNS4zRf5/QCeKPwCJKva6l05i18OWv4tZJFB
BuQAn36NT4DZoi5e9RTqm3XAfBQqiWup
=e27Z
-----END PGP SIGNATURE-----


--------------010909050008070704030105
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    -----BEGIN PGP SIGNED MESSAGE-----<br>
    Hash: SHA1<br>
    <br>
    Am 03.09.12 09:09, schrieb Gert Doering:<br>
    <span style="white-space: pre;">&gt; Hi,<br>
      &gt;<br>
      &gt; On Mon, Sep 03, 2012 at 08:49:42AM +0200, Arne Schwabe wrote:<br>
      &gt;&gt; Some BSD need the right salen, max(sizeof(v4),sizeof(v6))
      does not work. Since sa_len is not a member in sockaddr for Linux
      and Windows and SA_LEN is no available on Darwin, NetBSD
      explicitly set salem<br>
      &gt;<br>
      &gt; "Something sneaked into your keyboard"...<br>
      &gt;<br>
      &gt;&gt; + getnameinfo(&amp;addr-&gt;addr.sa, sizeof (struct
      sockaddr_in6),<br>
      &gt;&gt; + buf, sizeof (buf), NULL, 0, NI_NUMERICHOST);<br>
      &gt;<br>
      &gt; ... this very much looks like v1 of the patch...? :-)<br>
      &gt;<br>
      &gt; Anyway, what about defining an openvpn_sa_len() macro that
      will either<br>
      &gt; use SA_LEN() if it exists, or fall back to <br>
      &gt;<br>
      &gt; #define openvpn_sa_len(addr) ( addr-&gt;sa.sa_family ==
      AF_INET? sizeof(struct sockaddr_in) : sizeof(struct sockaddr_in6)
      )<br>
      &gt;<br>
      &gt; this will, of course, bite us when we implement IPv8, but
      should be fine<br>
      &gt; for 2.3...</span><br>
    <br>
    I will try to avoid this for now... I hope to convert openvpn to
    fully using getnameinfo/getaddrinfo<br>
    one day so that we do not need these deep look into the sockaddr
    anymore.<br>
    <br>
    <br>
    <span style="white-space: pre;">&gt; (Is there something magic in
      Autoconf to solve this? Must be a standard<br>
      &gt; problem...)<br>
      &gt;<br>
      &gt;</span><br>
    I think most people don't deal with raw sockaddr structs.
    getaddrinfo returns ai_addrlen.<br>
    <br>
    Arne<br>
    -----BEGIN PGP SIGNATURE-----<br>
    Version: GnuPG v1.4.12 (Darwin)<br>
    Comment: Using GnuPG with Mozilla - <a class="moz-txt-link-freetext" href="http://www.enigmail.net/">http://www.enigmail.net/</a><br>
    <br>
    iEYEARECAAYFAlBEWZUACgkQe8+cMNS4zRf5/QCeKPwCJKva6l05i18OWv4tZJFB<br>
    BuQAn36NT4DZoi5e9RTqm3XAfBQqiWup<br>
    =e27Z<br>
    -----END PGP SIGNATURE-----<br>
    <br>
  </body>
</html>

--------------010909050008070704030105--

