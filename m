Message-ID: <4FD86BDD.2060107@...1114...>
Date: Wed, 13 Jun 2012 12:30:53 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F438CF2.1060305@...515...>
	<CAEsd45Rw5nYYuMMq_Qy_5tQYagZh+EMHM+2Nugod1_1s-BHthA@...278...>
	<4F44F7F8.4090604@...1114...>
	<eb2837a3-ce55-4f52-b2fe-f822efc661f7@...1662...>
In-Reply-To: <eb2837a3-ce55-4f52-b2fe-f822efc661f7@...1662...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDAD10313B64224357E005248"
Subject: Re: [Openvpn-devel] OpenVPN 2.3-alpha1 preview 1 installer now
	available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debrabander <debrabander@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDAD10313B64224357E005248
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 22/02/12 20:49, debrabander wrote:
> This is not the a problem when building using the latest Mac OS X SDK.
> I've did a quick search and it seems to be a more common issue on some
> (old) Darwin platforms. Please try building again after applying the
> patch below.
>=20
>=20
> Signed-off-by: Frank de Brabander <debrabander@...277...>
> ---
>  socket.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Applied to master, with an extended commit note.


commit fe8a7f0cc25e6b9492bf0613025873c7a5f46ca5
Author: Frank de Brabander <debrabander@...277...>
Date:   Wed Feb 22 11:49:15 2012 -0800

    Fix reported compile issues on OSX 10.6.8
=20=20=20=20
    This is not the a problem when building using the latest Mac OS X SDK.
    I've did a quick search and it seems to be a more common issue on some
    (old) Darwin platforms.=20=20=20=20
=20=20=20=20
    [ Additional review note from Gert Doering:
=20=20=20=20
      IPV6_PKTINFO is part of the "extended socket API" defined in RFC2292.
      That RFC used IPV6_PKTINFO both for receiving the destination IPv6 ad=
dress
      in UDP packets, and for setting the source address for outgoing packe=
ts.
=20=20=20=20
      RFC2292 was updated by RFC3542, which renamed the "receive" function =
to
      IPV6_RECVPKTINFO, leaving the "sending" function as IPV6_PKTINFO - an=
d,
      subsequently, in FreeBSD they have different "setsockopt()" opcodes.
=20=20=20=20
      So, on a system that has *both*, we need to use IPV6_RECVPKTINFO for
      receving (turning it on with setsockopt) to make --multihome work, and
      IPV6_PKTINFO for sending (which we don't actually do).
=20=20=20=20
      On a system that only has IPV6_PKTINFO, because it's API only impleme=
nts
      2292 (MacOS up until 10.6), use IPV6_PKTINFO for setsockopt().
=20=20=20=20
      Now, the interesting question is whether a 10.5-compiled openvpn.exe
      will behave correctly under 10.7 if --multihome is active...
    ]
=20=20=20=20
    Signed-off-by: Frank de Brabander <debrabander@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: eb2837a3-ce55-4f52-b2fe-f822efc661f7@...1662...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/5591
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigDAD10313B64224357E005248
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/Ya90ACgkQDC186MBRfrpV4gCgi9MB2em2YiYFOKDGo4mXBLqJ
9zEAn18PfIwmeNZFLSAMWLw5auSeq+Yq
=cNI0
-----END PGP SIGNATURE-----

--------------enigDAD10313B64224357E005248--

