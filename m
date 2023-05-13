From: Melvin Vermeeren <vermeeren@...2730...>
Date: Sat, 13 May 2023 16:24:31 +0200
Message-ID: <7072303.gtipl9YmvM@...2731...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3995781.bqPgKRP4r2";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [Openvpn-devel] Automatically restart Linux systemd OpenVPN client
 service on failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--nextPart3995781.bqPgKRP4r2
From: Melvin Vermeeren <vermeeren@...2730...>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 13 May 2023 16:24:31 +0200
Message-ID: <7072303.gtipl9YmvM@...2731...>
Organization: vermware
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; protected-headers=v1
Content-Transfer-Encoding: 7bit

Hi all,

Today I changed some OpenVPN server configuration and restarted the service, 
thinking all clients will reconnect just fine as usual. Unlike other days 
however, all Linux clients ended up exploding due to unexpected tun-device 
recreation and lack of permission to do so, resulting in fatal exit with 
service failure. Quite a surprise to me, and a bit of a mess to fix!

After first researching Debian's OpenVPN package, I find the service is 
provided by OpenVPN itself. Looking further, I find a PR on GitHub from 2018.
https://github.com/OpenVPN/openvpn/pull/104

After doing some thinking I shared my thoughts there as well.
https://github.com/OpenVPN/openvpn/pull/104#issuecomment-1546384702

However, mailing list seems preferred for OpenVPN, so here it is!
I'll quote my message on GitHub here for convenience, I'll also add a ref from 
GitHub to this mail on the mailing list archives once I see it live.

> Today I was bitten by this issue. I adjusted some seemingly irrelevant
> options on a OpenVPN server instance and restarted it, expecting the clients
> to handle it gracefully. Because the clients drop a bunch of privileges
> however and OpenVPN decided recreation of the tun device was needed it ended
> in an explosion where all clients fatal exited and as a result the openvpn-
> client@...1685... for them failed. Quite a mess I had to manually untangle to
> get critical systems talking to each other again.
> 
> Personally I think the default should be to retry. A system service should
> do it's best to keep working, as it usually means it's part of a server or
> managed workstation, etc, and not a human user interacting with a VPN GUI or
> similar. Especially nasty if you rely on the VPN for remote access to the
> other machines, luckily didn't happen for me today.
> 
> I genuinely don't see a use case where you don't want it to automatically
> restart and try again on failure! Imagine if a DHCP client would stop trying
> if it encountered a very weird situation and fatal exited, resulting in a
> host without network connectivity. This with OpenVPN client feels very
> similar in principle to that.

It has been quite some years since 2018, and with things like remote work etc 
getting more common client VPN reliability I feel is much more important than 
before. Losing the client VPN could mean having to physically travel to the 
machine in question in order to fix it, as remote access could be impossible!

Thoughts on changing this by default?

Thanks,

-- 
Melvin Vermeeren
Systems engineer
--nextPart3995781.bqPgKRP4r2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiu1YAh/qzdXye6Dmpy9idxbqnZYFAmRfnZ8ACgkQpy9idxbq
nZaKnw/+J1l39Ec7DTpzvPhb0JgrGN7ia4cEnwTO/vmCoU8uG6Hfsk3Maqls/Xv7
d8D9CruO5HfVj9YJTqMQYBY7Y3ineNTnoMBHj1VMAN/QQU4v+DCqxkNxQ6wXd+4T
jluoccMJdX4b0YLR/XqwaMC9HS+7mnDLn//MyRl+XoqhA6t9D20Hagcb032wpmbX
Mt+rdEjtbU6OliwHl4W3XWfIuk80kINQgwV3VZ6feECj8S8RVVXTQaCkiZACPLYw
7d913yJIcaUF6UdhPvXOf8Vsj7Dcb31sAYgg1WNL7Fgmupy1cSoeTCSQ2XWrHEDQ
bWarFWSH617dhp5bE7n9ssS1+wfRAIKqXX+/2xgivSGVQAGOfDaMPgp8rT/GG7r1
AKQBtFBtHcfBd9HevdWhZohhvRaZoWWCdysad3ZWo3AbBW7YAbAFIogoAfRMseyl
bbFOO2teSwPHIQgI04tjw85H/6m58D70pRvvdcml2KUzRDWWYV7KIW2c+cY3KWEa
xeXBU2UYvozjVYqTG65zpjXcU6i6vI2d/cI+nEgw67eP3hMRCnsdFviW/KVYzhhn
9eLbRs8kLjgD91v/JXLxH/dUV4xe9eZC8DdUsNYl2L5XppQYrqXPHQwSZwEvP/PP
0N4sZte79P2TOAY7sNjV3APpZHUDcBspe9kVF+efsEt+rnGfvWw=
=gQuB
-----END PGP SIGNATURE-----

--nextPart3995781.bqPgKRP4r2--




