References: <1478870201-17943-1-git-send-email-davids@...515...>
	<1479165185-11730-1-git-send-email-davids@...515...>
	<20161116162621.GH28918@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <09f25564-0781-b702-a1dc-9e4aa0eb8dfd@...2080...>
Date: Wed, 16 Nov 2016 17:32:48 +0100
MIME-Version: 1.0
In-Reply-To: <20161116162621.GH28918@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] tun: Fix compiler warnings
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/11/16 17:26, Gert Doering wrote:
> Hi,
> 
> On Tue, Nov 15, 2016 at 12:13:05AM +0100, David Sommerseth wrote:
>> Fixes two compiler warnings idetified by using CFLAGS=-O2
> 
> Spelling...

Meh. Will fix that one.

>> 1) ifconfig_ipv6_remote is only used on Solaris, move the 
>> declaration and assignment of this variable into the 
>> TARGET_SOLARIS block.
>> 
>> 2) Linux have it's own open_tun() function and does not depend on
>> open_tun_generic() at all.  So do not exclude open_tun_generic()
>> if TARGET_LINUX is defined.
> 
> Should that be an "So do not include... " or "So exclude..."?

yes :)

>> @@ -915,7 +913,6 @@ do_ifconfig (struct tuntap *tt, 
>> management_android_control (management, "IFCONFIG",
>> buf_bptr(&out));
>> 
>> #elif defined(TARGET_SOLARIS) -
> 
> Whitespace change - intentional?

Yes, but we can skip it if it is a deal-breaker.

>> @@ -977,6 +974,9 @@ do_ifconfig (struct tuntap *tt,
>> 
>> if ( tt->type == DEV_TYPE_TUN ) { +	      const char
>> *ifconfig_ipv6_remote = NULL; + +	      ifconfig_ipv6_remote =
>> print_in6_addr (tt->remote_ipv6, 0, &gc);
> 
> Why have an extra initialization with NULL here, if all you want
> is "assing print_in6_addr"?  Single line should be good (unless too
> long).

Yes, the line would exceed 80 characters, so this looked more readable.


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYLIowAAoJEIbPlEyWcf3yqh4P/0XfeJtFkhyv0Zy9hpMvWqXd
UUvzy1eWi+YDpD0yj1gnsNXvGuuDSKdYJ8N7xihxJ+YbGQaHYq6h4CSzy9v8LXc1
tcdStM+73cGFOWeJujLsazJYmYJVxicbSkIU0wqTdjqI55Ac55Qzp5F5mns9gVoO
2bMVMmfrNUWTG/vRK77VU0/0lfuNAeXp0WdY0Xzz3ee+hWxFaVorVidVwmEqfiWk
87mVLC79jdPjYqlk8jMmaw2Cd32/sn5rje+9Lg49P8VghFOduxqx8oD7PQKzp9sA
HIcR0KPAPlHWgQpd+TX+ljHiEW/7jVrRuJNaubXSjFuDB/Ru9xxjJSL/DWPA4ahr
jaw8d/K1AdivYGhNGs3LqvFOsEJiZEK1Keo2JOPVSo7AoZDWUuYw1B8h3EcACPHr
RDG4Cay+tW6vQGyhcx+Q723f/ZNDG4pFfi4sYkiQ/xhQ4LZz3qR/J3hy13GjIVe0
lvg7vEZCJipPw7dgqDnyD4xrdlNwovkzSPv5GL/hQnyc+k9iYZyG825hYrftmDL6
BlJDyn2uXUXISHYSoibfRuBLOGEXjY14opWB1P5ZNHJL4NfdfPZOE2eZJvh7oF5J
NqA14XvRGl0qlYsJN/bBJAHsf+RSKD3pKEwcNjIkJlCJj1AvBD4Nd/TQ51ok1r1r
+R5LyZIRg0UtQrmWpZXi
=Xo64
-----END PGP SIGNATURE-----

