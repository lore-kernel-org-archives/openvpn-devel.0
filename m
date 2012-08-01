Message-ID: <50199975.9030802@...1227...>
Date: Wed, 01 Aug 2012 23:02:45 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1343837470-3923-1-git-send-email-arne@...1227...>
	<1343837470-3923-4-git-send-email-arne@...1227...>
	<20120801203832.GK2535@...1296...>
In-Reply-To: <20120801203832.GK2535@...1296...>
Content-Type: multipart/alternative;
	boundary="------------030808030505010600020805"
Subject: Re: [Openvpn-devel] [PATCH 3/4] Merge almost identical
 create_socket_tcp and create_socket_tcp6
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
--------------030808030505010600020805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 01.08.12 22:38, schrieb Gert Doering:
> Hi,
>
> On Wed, Aug 01, 2012 at 06:11:09PM +0200, Arne Schwabe wrote:
>> @@ -1099,15 +1068,7 @@ socket_connect (socket_descriptor_t *sd,
>> if (*signal_received)
>> goto done;
>>
>> - switch(local->addr.sa.sa_family)
>> - {
>> - case PF_INET6:
>> - *sd = create_socket_tcp6 ();
>> - break;
>> - case PF_INET:
>> - *sd = create_socket_tcp ();
>> - break;
>> - }
>> + create_socket_tcp(local->addr.sa.sa_family);
>
> I might be overlooking something, but shouldn't that be
>
> + *sd = create_socket_tcp(local->addr.sa.sa_family);
>
>
Yes you are right.


Arne
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAZmXUACgkQe8+cMNS4zRdDrQCfdTfEEbZAF+F1UlcoW22lk2QG
UpkAmwWhOrJqOHsuaYlcD2JLcifH9VfY
=nrKu
-----END PGP SIGNATURE-----


--------------030808030505010600020805
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
    Am 01.08.12 22:38, schrieb Gert Doering:<br>
    <span style="white-space: pre;">&gt; Hi,<br>
      &gt;<br>
      &gt; On Wed, Aug 01, 2012 at 06:11:09PM +0200, Arne Schwabe wrote:<br>
      &gt;&gt; @@ -1099,15 +1068,7 @@ socket_connect
      (socket_descriptor_t *sd,<br>
      &gt;&gt; if (*signal_received)<br>
      &gt;&gt; goto done;<br>
      &gt;&gt; <br>
      &gt;&gt; - switch(local-&gt;addr.sa.sa_family)<br>
      &gt;&gt; - {<br>
      &gt;&gt; - case PF_INET6:<br>
      &gt;&gt; - *sd = create_socket_tcp6 ();<br>
      &gt;&gt; - break;<br>
      &gt;&gt; - case PF_INET:<br>
      &gt;&gt; - *sd = create_socket_tcp ();<br>
      &gt;&gt; - break;<br>
      &gt;&gt; - }<br>
      &gt;&gt; + create_socket_tcp(local-&gt;addr.sa.sa_family);<br>
      &gt;<br>
      &gt; I might be overlooking something, but shouldn't that be<br>
      &gt;<br>
      &gt; + *sd = create_socket_tcp(local-&gt;addr.sa.sa_family);<br>
      &gt;<br>
      &gt;</span><br>
    Yes you are right.<br>
    <br>
    <br>
    Arne<br>
    -----BEGIN PGP SIGNATURE-----<br>
    Version: GnuPG v1.4.12 (Darwin)<br>
    Comment: Using GnuPG with Mozilla - <a class="moz-txt-link-freetext" href="http://enigmail.mozdev.org/">http://enigmail.mozdev.org/</a><br>
    <br>
    iEYEARECAAYFAlAZmXUACgkQe8+cMNS4zRdDrQCfdTfEEbZAF+F1UlcoW22lk2QG<br>
    UpkAmwWhOrJqOHsuaYlcD2JLcifH9VfY<br>
    =nrKu<br>
    -----END PGP SIGNATURE-----<br>
    <br>
  </body>
</html>

--------------030808030505010600020805--

