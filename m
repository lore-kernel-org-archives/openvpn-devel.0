Message-ID: <5486B561.8080104@...515...>
Date: Tue, 09 Dec 2014 10:40:01 +0200
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <54833CC6.8010507@...1490...>
In-Reply-To: <54833CC6.8010507@...1490...>
Subject: Re: [Openvpn-devel] feature request: get openvpn to use closest
	server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jason Haar <Jason_Haar@...1490...>, openvpn-devel@lists.sourceforge.net


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,
>
>
> So I propose openvpn itself could solve this problem - if it had some
> application layer way of "pinging" all available openvpn servers and
> choosing the one that responds "best". I'd suggest it only be supported
> for sites using "tls-auth" but that it doesn't need the full cert check
> - that way it's one packet from the client and one return packet from
> the server. I'd also suggest the server can respond with a "don't use
> me" message: maybe a new config option "pause-logins /path/filename" so
> that sysadmins can write their own load tests and create/delete that
> file when needed. The client could send "openvpn-pings" to each server
> (when the DNS server name resolves to >1 IP) and try up to 3 times
> before making a decision. ie packet loss means there needs to be a retry
> aspect, 3 failures means the server is down/firewalled, but if the
> server responds with "don't use me" then it's treated as "down" too.
> Then the client can simply figure out which positive return had the
> smallest latency and then use that to influence the order in which it
> tries to log into the servers. ie it doesn't replace the current server
> connection logic, it just re-sorts it before carrying on as usual
Would 3 pings and ping replies adequately measure the overall
performance of OpenVPN server even for one particular VPN session? What
if there's a temporary congestion somewhere between the "best" server
and the client? I think that reliably determining the best server (on
average) would require long-term statistics to be any good, but that
would only work for clients that don't move around. In a road-warrior
scenario what you suggest would work better.
>
> I also think it should be done with some "openvpn-ping" instead of icmp
> ping because it confirms the server is available on the protocol/port
> combination, whereas icmp doesn't
In what kind of scenario would an OpenVPN server not be available, if
the server itself still responds to pings?

Best regards,

- --=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlSGtWEACgkQwp2X7RmNIqOkeACeJb3f5+Rgl/sSVBSi2FRMfTu2
sgUAoJI65DBooIxLd9t4beYeTUChxUm5
=3DM0FU
-----END PGP SIGNATURE-----



