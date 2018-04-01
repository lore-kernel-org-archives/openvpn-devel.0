Date: Sun, 1 Apr 2018 21:34:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180401193456.GI69387@...1296...>
References: <20180401063058.23913-1-gert@...1296...>
 <CAKuzo_gRyd++KVmH=iGALbz0kjPiXLhK6DkAGA0Uu0mcV6RG8A@...278...>
 <20180401153422.GE69387@...1296...>
 <CAEsd45QQ-j=R9mWDuKkpvwgFMnFY4sSUdoZtYodKxxio8iR+6w@...278...>
 <BC0A595E-A0E3-4355-BAB3-37E9FA75DD37@...277...>
 <20180401183928.GH69387@...1296...>
 <9FAA40DB-C459-47AF-92B3-B02FD769886E@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sszduGT9fQUHJP/+"
Content-Disposition: inline
In-Reply-To: <9FAA40DB-C459-47AF-92B3-B02FD769886E@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Depreciate IPv4-related options.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marvin Adeff <volleynbike@...277...>
Cc: Gert Doering <gert@...1296...>, "Jonathan K. Bullard" <jkbullard@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sszduGT9fQUHJP/+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 01, 2018 at 12:21:53PM -0700, Marvin Adeff wrote:
> I had not considered the extra work and code required to maintain both ve=
rsions. But I get it now. Here is the unfortunate position this puts us in:
[..]

Well, that part of my e-mail was a bit of frustration speaking - I've
been advocating IPv6 for over 20 years now, and while large parts of
the access networks are offering IPv6 now, other parts are still being
*built* with IPv4 only, or stubbornly stick to IPv4 only...  thus, double
work everywhere, not only in OpenVPN, seemingly for a lifetime.

> So if OpenVPN lost ipv4 support anytime soon, we would be in a world of h=
urt.

As far as OpenVPN is concerned, I am not aware of any plans to remove=20
IPv4 support.

The extra code adds some maintenance and testing effort, but since this
is all in place now (especially the test setups with "connect over IPv4
or IPv6" and "send IPv4 and IPv6 packets through the test VPN") it would
be more work to rip out IPv4 now... :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--sszduGT9fQUHJP/+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJawTRfAAoJEB2Cnv7KVigSADsL/3Cg9lH74iUob7eQC9TNFg2R
sGAih9l38dPE3ZpMQyCNTQvex/k2tXnBG0Zfeb1gE2Xj/9hnySx5HRpuelWPqU3n
5u6tn0E+QmICyObdfWI1tCsfXTRV6gGoIz4wqDTnsmINfoTHUhhv34rZYRvX2Fmo
rhBNi2Sonop4P+mqdSnjd78teUSqUwt8pT8FcyI0iW7A8rJOZiZWLqvrkZ6V+GPD
eqGJMikEH4y3t56Ab5gxwDcaBBZgpSKOAJ3LdadxAX/91OcAcKjZAzrMEPMwuKao
WZLZ5OcbXhQBzWJROMe5j50Ye+EipnzlHvY2enlG9viflS9tQGVtmR9KvO2k4gVC
sPxCy1T2jAT/un9D05XEp4PlFtei2/22lCYtgb9ZYIzQCahiOq2VsEJRyAg38S5l
9amRwg6NWDbW9ieYAcVtyAlirQfET6tKEVN+acq7TGP2y5ujiU/8byFYhvFLzJkC
E1+X8co024QqM3V2VqFr5IoPKaRr07YTgKMhDYk2xw==
=MWUf
-----END PGP SIGNATURE-----

--sszduGT9fQUHJP/+--

