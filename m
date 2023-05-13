From: Melvin Vermeeren <vermeeren@...2730...>
Date: Sat, 13 May 2023 16:47:35 +0200
Message-ID: <5431695.haC6HkEk0m@...2731...>
In-Reply-To: <40c32f7b-b3a5-a09d-5b21-943b4a9ec736@...1227...>
References: <7072303.gtipl9YmvM@...2731...>
 <40c32f7b-b3a5-a09d-5b21-943b4a9ec736@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2192798.FMhQkTaH9n";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] Automatically restart Linux systemd OpenVPN
 client service on failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, Arne Schwabe <arne@...1227...>

--nextPart2192798.FMhQkTaH9n
From: Melvin Vermeeren <vermeeren@...2730...>
Date: Sat, 13 May 2023 16:47:35 +0200
Message-ID: <5431695.haC6HkEk0m@...2731...>
Organization: vermware
In-Reply-To: <40c32f7b-b3a5-a09d-5b21-943b4a9ec736@...1227...>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; protected-headers=v1
Content-Transfer-Encoding: 7bit

Hi Arne,

On Saturday, 13 May 2023 16:28:29 CEST Arne Schwabe wrote:
> Can you provide some more detail here? Otherwise this seem a bit
> nebulously to me what exactly explodes and goes wrong.

I changed the --keepalive setting on the server, lowering the timeout from 120 
to 60 seconds to make things somewhat more responsive. Figured a small push 
change like this wouldn't really cause trouble.

This triggered a TUN device close/reopen, which makes sense in hindsight. 
Clients are configured to drop privilege with --user and --group after 
connecting, so they could not make the change needed.

> NOTE: Pulled options changed on restart, will need to close and reopen
> TUN/TAP device.
> ...
> ERROR: Cannot ioctl TUNSETIFF tun_vpn: Operation not permitted (errno=1)
> Exiting due to fatal error

This is not the only case though, I also had some problems with DCO on a 
Debian testing client recently, resulting in failure after network was offline 
for quite a while. Official Debian package DCO 0.0+git20230324-1.

> TLS Error: TLS key negotiation failed to occur within 60 seconds (check your
> network connectivity)
> TLS Error: TLS handshake failed
> ... A lot of the same ...
> TLS Error: TLS key negotiation failed to occur within 60 seconds (check your
> network connectivity)
> TLS Error: TLS handshake failed
> TLS: tls_multi_process: killed expiring key
> No encryption key found. Purging data channel keys
> dco_del_key: netlink out of memory error: No buffer space available
> (errno=105)
> Exiting due to fatal error

In some cases this is arguably user/admin configuration error, but in other 
cases it is genuinely bugs or problems that can cause OpenVPN to fail.

From a security point of view, it's also better to drop privileges after 
connection and if things really change a lot error, fail, exit and get 
restarted by systemd, with privileges, set things up and drop them again.
The alternative is to forever run OpenVPN client process as root.

In conclusion I don't see a reason to *not* automatically restart and retry 
when configured as a system service through systemd. GUI clients might be a 
different matter, though even there I'd argue for auto-reconnect until the 
human user tells the program to stop.

Cheers,

-- 
Melvin Vermeeren
Systems engineer
--nextPart2192798.FMhQkTaH9n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiu1YAh/qzdXye6Dmpy9idxbqnZYFAmRfowcACgkQpy9idxbq
nZZadQ/5ATTh3JO2+Oh1vdDU3B22e4CitxR3z1W3tCbHU3yWCEDJIsXK/74EofvB
6YwkEi9rGWcJ0qwDAP8/oyjwm1NNr5lHoWcOOvGoOxKlUF6c9/Au8+qigv9kY7dt
O+VMRdbjyiNtgkyfgVhxod0Z3brREEZsKup5F2uiA13+WYKZsIsNyLzgd4OVucHr
srYLgGcTki/8nnAoJWoGSDbVYPLB26//Kk7nnhpiW0aDvI0hYmqAqFiZICGEyGc5
zfYe9/bw/whdG4cjQ417/DYXM4gddPJ5fj1/CXnigbuQrtYZvfZNaag4By8NThIr
fKpjEZ/h3/5EaovkME91YIuMiHADkcqOWQAnjnf3UtPL/0DD8ZqR4E4iCErD7G08
hqzNl2sBteysKgY/5iEB4f8ALAcsBakLwqxoViHcTa+8t+n8aoBBTEfLlLlPadaH
qzbUUF+VuW8Om3+7EpDE3GK4hgQxZtbZbwKTFKlaGGxqzhBARAoAzFCDK7cL5sSx
dsfUIn9E3Sz8dvm85FES12Z7+T7RRqxhMvdWL8OgbWexhFkEOmqvx1qTC+3mAKCH
AEZBEVx/m4YkuMCkmUwOeaEJP76uSKT8mtJ+x41+/4ebb7aq1x3HNhX7HUesb+63
c7MX8468p9k9AMwjMbtqas+Df19X9FYreHvl3IaFPMCZ3vS6/ow=
=KAF4
-----END PGP SIGNATURE-----

--nextPart2192798.FMhQkTaH9n--




