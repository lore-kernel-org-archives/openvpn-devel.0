Message-ID: <513F0219.6070709@...1227...>
Date: Tue, 12 Mar 2013 11:23:21 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <C673F57BE2DD3148AC2DD4AF464686F901BBDB56@...1815...>
	<1363032625-23311-1-git-send-email-gert@...1296...>
	<513E4DEB.7000403@...1227...>
	<1CED409804E2164C8104F9E623B08B9013B8D6EDA6@...1436...>
	<20130312100706.GN953@...1296...>
In-Reply-To: <20130312100706.GN953@...1296...>
Content-Type: multipart/alternative;
	boundary="------------090902020309010502090501"
Subject: Re: [Openvpn-devel] [PATCH v2] Repair "tcp server queue overflow"
 brokenness, more <stdbool.h> fallout.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090902020309010502090501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 12.03.13 11:07, schrieb Gert Doering:
> Hi,
>
> On Tue, Mar 12, 2013 at 09:32:36AM +0100, Steffan Karger wrote:
>> Shouldn't the return type be size_t or at least unsigned int, as
mbuf->len is also of type unsigned int?
>
> Well, unsigned int, as ->len is not a size_t. 
>
> Not that it makes any real difference as we're talking about a range
> between "0" and "65" here.  But anyway.  Patch v2 is below.
>
ACK to that too.

Arne
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE/AhkACgkQe8+cMNS4zRfErwCcDvRSIfQ22qAT8C/PsNlaScUV
L0YAoITnJqqV/D4HeLZFaXMf+B7k+ceG
=FIBk
-----END PGP SIGNATURE-----


--------------090902020309010502090501
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
    Am 12.03.13 11:07, schrieb Gert Doering:<br>
    <span style="white-space: pre;">&gt; Hi,<br>
      &gt;<br>
      &gt; On Tue, Mar 12, 2013 at 09:32:36AM +0100, Steffan Karger
      wrote:<br>
      &gt;&gt; Shouldn't the return type be size_t or at least unsigned
      int, as mbuf-&gt;len is also of type unsigned int?<br>
      &gt;<br>
      &gt; Well, unsigned int, as -&gt;len is not a size_t.&nbsp; <br>
      &gt;<br>
      &gt; Not that it makes any real difference as we're talking about
      a range <br>
      &gt; between "0" and "65" here.&nbsp; But anyway.&nbsp; Patch v2 is below.<br>
      &gt;</span><br>
    ACK to that too.<br>
    <br>
    Arne<br>
    -----BEGIN PGP SIGNATURE-----<br>
    Version: GnuPG v1.4.13 (Darwin)<br>
    Comment: Using GnuPG with Thunderbird - <a class="moz-txt-link-freetext" href="http://www.enigmail.net/">http://www.enigmail.net/</a><br>
    <br>
    iEYEARECAAYFAlE/AhkACgkQe8+cMNS4zRfErwCcDvRSIfQ22qAT8C/PsNlaScUV<br>
    L0YAoITnJqqV/D4HeLZFaXMf+B7k+ceG<br>
    =FIBk<br>
    -----END PGP SIGNATURE-----<br>
    <br>
  </body>
</html>

--------------090902020309010502090501--

