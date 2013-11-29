Message-ID: <5298EF88.20609@...1227...>
Date: Fri, 29 Nov 2013 20:48:24 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1385382680-5912-1-git-send-email-arne@...1227...>
	<1385382680-5912-6-git-send-email-arne@...1227...>
	<20131129194258.GL161@...1296...>
In-Reply-To: <20131129194258.GL161@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="XKsiRWmPP48wUraoq41S6Nex4tSpCD4qx"
Subject: Re: [Openvpn-devel] [Patch v2 6/9] Implement dual stack client
 support for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XKsiRWmPP48wUraoq41S6Nex4tSpCD4qx
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 29.11.13 20:42, schrieb Gert Doering:
> Hi,
>
> On Mon, Nov 25, 2013 at 01:31:17PM +0100, Arne Schwabe wrote:
>> This patch contains a number of changes. I did not further spit this sin=
ce some changes make only sense being changed together.
> ACK, but...
>
>  - some parts of the patch did not apply cleanly due to whitespace issues
>    (most likely I caused them in the previous merges, meh, but some of th=
em
>    were not my doing...), so I had to apply a few things manually - I=20
>    *think* I got it all right, but hey...
>
>    - while at it, I've cleaned up more whitespace (trailing blanks)
>
>  - as discussed on IRC, I've adapted the complex if() condition in socket=
.h
>    (link_socket_set_outgoing_addr()
>
>  - I've included the fix to make "openvpn --test-crypto" work again
>
>  - I've changed the patch to tun.c to use "local_public" (I assume this=20
>    was intended and just a copy-paste overlook)
>
>  - I've changed the protocol list to add "tcp4-server", "tcp4-client", and
>    also changed "tcp-server" and "tcp-client" from AF_INET to AF_UNSPEC -
>    and I'm not 100% sure if that is "right" for tcp-server.
>
> So - amended patch below.  Arne, could you please verify that these chang=
es
> are all good and formally ACK again?  Transparency, and such :-)
>
>
ACK and thanks for doing my work :)




--XKsiRWmPP48wUraoq41S6Nex4tSpCD4qx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKY740ACgkQe8+cMNS4zRfdHQCgiXA0D+vXlNuSQlfjNqSRL5Dm
TNIAn1Dqrzml2IdrQsODZevFpCsoIuuz
=PAxU
-----END PGP SIGNATURE-----

--XKsiRWmPP48wUraoq41S6Nex4tSpCD4qx--

