Message-ID: <4D7A771B.5040907@...1114...>
Date: Fri, 11 Mar 2011 20:25:15 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <AANLkTi=gX2zHuk40P5RVtM8XmgZCp3V5_o20OeSy80N_@...278...>	<20110311090414.GE9835@...1296...>	<4D79ECC4.8010805@...1114...>
	<AANLkTi=5kX-fweV=wzAR0e_mMpvBbNuKGkt0rNQVUZ5P@...278...>
In-Reply-To: <AANLkTi=5kX-fweV=wzAR0e_mMpvBbNuKGkt0rNQVUZ5P@...278...>
Subject: Re: [Openvpn-devel] openvpn protocol breaks proxies intercepting
 SSL ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Vineet Kumar <vineet.kumar@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/03/11 20:09, Vineet Kumar wrote:
> Thanks for your replies.
>=20
> So,
> - without --tls-auth
> - with tcp as the transport
> if we want to make openvpn purely SSL then are these the complete set
> of things to take care of?:
> 1. Move all P_CONTROL_* messages to be encapsulated in SSL
> 2. Stop adding reliability layer over SSL
>=20
> Let's say, theoretically, that the above 2 steps are taken care of
> (easier said than don, for sure). Will the resulting VPN setup then
> pass through transparent SSL proxies unbroken?

That sounds pretty much correct.  To be on the very safe side, it would
probably be better then to use OpenSSL's built in socket read/write
functions as well.  As that infrastructure takes care of the proper defined
SSL handshake.  This might be overkill though, if you're able to perform
the SSL handshake exactly the same way using the socket functions in
OpenVPN.  So the key point is to make the wire traffic look exactly like
the SSL wire protocol is defined.

It could be a good exercise to see if the DTLS links from Markus K=F6tter
passes such a firewall/proxy - both using TCP and UDP.  If that works
better, then see how adaptable this solution is compared to the
implementation in OpenVPN.  We can not remove the support for the current
OpenVPN wire format - as we need to be compatible (at least as long as we
are on OpenVPN 2.x) for older clients.


kind regards,

David Sommerseth



> On Fri, Mar 11, 2011 at 1:35 AM, David Sommerseth
> <openvpn.list@...1114...> wrote:
> On 11/03/11 10:04, Gert Doering wrote:
> | Hi,
> |
> | On Thu, Mar 10, 2011 at 05:04:48PM -0800, Vineet Kumar wrote:
> |> Also, doesn't this make openvpn different from other SSL VPNs which
> |> advertise the fact that they are truly SSL?
> |
> | Well, OpenVPN is "truly SSL", but it's not "using https as a browser wo=
uld
> | do to hide the fact that there is a VPN inside"...
>=20
> Kind of.  Gert is basically correct.  But it is important to understand t=
hat
> OpenVPN doesn't use the SSL wire protocol directly, like the majority of =
SSL
> applications does.  So all the SSL packets from OpenVPN are encapsulated =
in
> a
> kind of OpenVPN container.  Which is why some strict proxies or deep pack=
et
> inspection firewalls might not allow OpenVPN traffic.
>=20
> The reason for this is that OpenVPN is primarily written for the UDP
> protocol.
> ~ While SSL itself is very TCP oriented.  To my knowledge, there are no U=
DP
> transport support in OpenSSL.  So OpenVPN uses OpenSSL differently,
> intercepting the network connections and sending the data through OpenVPN=
's
> own network socket infrastructure.  If OpenVPN's HMAC support (--tls-auth)
> is
> enabled, some extra bytes are added on top of the SSL packet itself.
>=20
> Of course, it would probably be possible (I have not investigated this) to
> add
> a feature which restricts OpenVPN to use the core SSL protocol, without
>  this
> encapsulation on top of the SSL packets.  However, when such a feature is
> enabled, it would restrict the usage of TCP.  In addition, the --tls-auth
> feature would not be useful in at all.
>=20
>=20
> kind regards,
>=20
> David Sommerseth
>>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk16dxsACgkQDC186MBRfrpzGACfQfYfHf1nGfsAu99zXyskv18v
15MAoKmSPvIEAp0TqWSMp53VxzIgfIAw
=3D2X67
-----END PGP SIGNATURE-----

