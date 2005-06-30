Message-ID: <42C3AD6E.1080907@...428...>
From: Hartmut Goebel <h.goebel@...428...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Status and Roadmap for IPv6 Support
References: <42C29B31.4010202@...428...> <Pine.LNX.4.58.0506291113130.27900@...41...>
In-Reply-To: <Pine.LNX.4.58.0506291113130.27900@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Jun 30 01:28:09 2005
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello,

Thanks for your answer.

>>1a) As far as I've found out, OpenVPN 2.0 supports forwarding IPv6 when
>>using tun+tun-ipv6 or tap. But neither of the build-in commands (like
>>route, ifconfig, server, push/pull) supprot IPv6-addresses or IPv6
>>Name-lookup.
>>
>>Is this correct, or have I overlooked something?
>=20
>=20
> That is correct for OpenVPN 1.6 and 2.0...  But JuanJo Ciarlante's IPv6=20
> patch against 2.0 adds IPv6 support in a much more substantial way.

I tested this patch but it seams to only target issues about forwarding
IPv6 packets. OpenVPn options/commands like 'route' are anchanged and
still not able to handle IPvp addresses. This is since
openvpn_inet_aton() does only suppport dotted quads.

Or have I overlooked something?

> I am mirroring a recent snapshot of the patch:

Thanks.

> The patch is planned for inclusion in OpenVPN 2.1, though people are usin=
g=20
> it today with 2.0.

Any plan about when should 2.1 be released?

--=20
Sch=F6nen Gru=DF - Regards
Hartmut Goebel

| Hartmut Goebel             | IT-Security -- effizient |
| h.goebel@...428... | www.goebel-consult.de    |


