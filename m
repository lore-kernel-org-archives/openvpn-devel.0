Message-ID: <52456F61.3000104@...1114...>
Date: Fri, 27 Sep 2013 13:43:29 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAN_jwOsXhs-qTqOmrqhNk+Jf6-pRSBVVTovShLGgQAKKTZkE4g@...278...>
	<554440252.59882.1380270883311.JavaMail.zimbra@...1795...>
	<CAN_jwOvixY5Jz7Rheq-=o40saprsoQmxRB9yn3-jdCmFa9VM0A@...278...>
In-Reply-To: <CAN_jwOvixY5Jz7Rheq-=o40saprsoQmxRB9yn3-jdCmFa9VM0A@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="65OowlmBqDF8uOoWm3KMjKCQwnV6LTxBA"
Subject: Re: [Openvpn-devel] [Openvpn-users] Does openvpn 2.3.2 has memory
	leak?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Brad Zhang <hebei5000@...277...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--65OowlmBqDF8uOoWm3KMjKCQwnV6LTxBA
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 27/09/13 11:45, Brad Zhang wrote:
> Thanks David for your so quickly replying.
>
> 6.
> I want to use polarssl, so I upgrade the openvpn from 2.1 rc4 to 2.3.2.
> Openvpn 2.2.2 does not support polarssl.
> But openvpn 2.3.2 with polarssl also has memory leak.
> openvpn2.3.2 + polarssl + 200 connections.
> initiate                       31M
> renegotiate 1            44M
> renegotiate 2            44M
> renegotiate 3            44M
> renegotiate 4            45M

Okay, but 2.1_rc4 is really too old to compare against.  It's from April
2007!  And OpenVPN 2.1.4 (released Nov 2010) is not the same as 2.1_rc4.

And no releases before 2.3 supports PolarSSL.  So if you're able to test
2.1_rc4, please compile OpenVPN 2.2.2 (released Dec 2011).  OpenVPN is a
fairly trivial package to compile and test.  It only provides a single
binary which you need to copy out and run.  There's no additional files
or libraries required to run.

The reason I ask for 2.2.2 testing is that the gap between 2.2.x and
2.3.x is quite big - especially on the SSL layer side.  In addition, the
networking code has been modified a lot too, to implement IPv6 support
in 2.3.  And I don't want to start looking at those changes before I
know 2.2.2 is not leaking.  Because if 2.2.2 is leaking, then we need to
look at completely different code changes.


> 7.
> I do not use plugin or script in openvpn 2.3.2.
> This is server config:
> dev tun0
> dev-type tun
> mode server
> tls-server
> tun-mtu 1500
> proto tcp-server
> local 0.0.0.0
> port 443
> persist-key
> persist-tun
> verb 3
> mute 20
> keepalive 10 60
> cipher DES-EDE3-CBC
> auth SHA1
> ca ca.crt
> cert server.crt
> key server.pem
> max-clients 2000
> dh dh.dh
> duplicate-cn
> topology subnet
> server 192.168.111.0 255.255.255.0
> push "route 11.11.1.0 255.255.255.0"
> reneg-sec 600
> management 127.0.0.1 7505
> status /tmp/status 30
> status-version 2
> client-config-dir /tmp/ccd/

All this looks pretty fine.  It's basically a pretty standard server
config.  I suspect this leak is happening somewhere around the SSL
session handling, or the code paths along "multi learn address".  But I
can't say for sure yet.


--
kind regards,

David Sommerseth



> On Fri, Sep 27, 2013 at 4:34 PM, David Sommerseth
> <openvpn.list@...1114... <mailto:openvpn.list@...1114...>>
> wrote:
>=20
>     ----- Original Message -----
>     > From: "Brad Zhang" <hebei5000@...277... <mailto:hebei5000@...277...=
>>
>     > To: openvpn-users@lists.sourceforge.net
>     <mailto:openvpn-users@lists.sourceforge.net>
>     > Sent: Friday, 27 September, 2013 8:11:56 AM
>     > Subject: [Openvpn-users] Does openvpn 2.3.2 has memory leak?
>     >
>     > Hi all,
>     >
>     > I tested openvpn 2.3.2 (openssl) with 200 connections. Set the
>     renegotiation
>     > value to 600 seconds.
>     >
>     > initiate: 136M
>     > renegotiate 1 259M
>=20
>     This gap from initial to the first renegotiation isn't unexpected.
>      It's not
>     necessarily a leak itself, but most likely memory allocated for each
>     client.
>     We've estimated earlier that it's roughly 1MB per client.  Your
>     growth here
>     is around 600KB per client, so I'd say that's within the expected
>     limits.
>=20
>     > renegotiate 2 262M
>     > renegotiate 3 264M
>     > renegotiate 4 266M
>     > renegotiate 5 267M
>=20
>     Here you have incremental steps of 2MB per renegotiation, which
>     means with
>     200 clients roughly 10KB per client.  This does however sound like a
>     smaller
>     memory leak.
>=20
>     For wow long time did you run this test?  Did you let the clients
>     disconnect at then end to see if the memory impact was reduced after
>     OpenVPN
>     releases the sessions?  (OpenVPN may keep session data for some time
>     after a
>     disconnect in case it was connection drop-out, esp. with UDP.  Look at
>     --explicit-exit-notify in the man page for some more information)
>=20
>     Also, how did you measure OpenVPN's memory usage?
>=20
>     > I have tried the openvpn 2.1 rc4, there is no this issue. I do not
>     know why
>     > the memory usage will increase after one time renegotiation. Could
>     someone
>     > help me?
>=20
>     To compare against 2.1_rc4 is a bit too big gap.  I'd appreciate if y=
ou
>     could run your test against 2.2.2.  And if that's still leaking, you
>     would
>     need to check against 2.1.4 (the last 2.1 community version)
>=20
>     Could we also see your server config?  Just to see if you use some
>     kind of
>     plugins, script hooks or other possible candidates for triggering
>     this issue.
>=20
>     I'm running OpenVPN 2.3 servers a couple of places, but not with 200
>     clients.
>     But I've not noticed any particular issues there.  However, if the
>     leak is
>     ~10KB per client, it would most likely have had scheduled maintenance
>     reboots happening before noticing a leak.
>=20
>=20
>     --
>     kind regards,
>=20
>     David Sommerseth
>=20
>=20


--=20
kind regards,

David Sommerseth


--65OowlmBqDF8uOoWm3KMjKCQwnV6LTxBA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJFb2YACgkQDC186MBRfroO/gCdG6dn48FUt9yuMxi1e8BmAqrd
aGIAn1hevflchb8nfQ8RvXDNEF+KjrmR
=NOa6
-----END PGP SIGNATURE-----

--65OowlmBqDF8uOoWm3KMjKCQwnV6LTxBA--

