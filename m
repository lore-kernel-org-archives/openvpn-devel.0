Message-ID: <504F7E14.8080600@...1114...>
Date: Tue, 11 Sep 2012 20:08:20 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1347154246-20143-1-git-send-email-dazo@...384...>
In-Reply-To: <1347154246-20143-1-git-send-email-dazo@...384...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8A77E3B6E1A91E196546FFA7"
Subject: Re: [Openvpn-devel] [PATCH] Fix reconnect issues when --push and
 UDP is used on the server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8A77E3B6E1A91E196546FFA7
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 09/09/12 03:30, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> When the server is configured with UDP and --push statements, reconnecting
> often fails by the client never receiving PUSH_REPLY.  The client sends
> PUSH_REQUEST and the server logs these requests but does not send them.
>=20
> This bug got introduced in commit ff65da3a230b658b2c1d52dc1a48612e80a2eb42
> which tries to avoid sending duplicated PUSH messages if the client/server
> connection is slow.
>=20
> This patch keeps this behaviour, but instead of a session wide PUSH_REPLY
> block it sets an expiry time for the PUSH_REPLY block.  The expiry time
> is set to 30 seconds.
>=20
> Signed-off-by: David Sommerseth <davids@...1347...>
> Cc: James Yonan <james@...515...>
> ---
> The solution here probably isn't the optimal fix, as the PUSH_REPLY block
> should be reset when the client confirms the connection is established.
> However, resetting the context's sent_push_reply variable turned out to
> be tricky, as it already was set to  '0' on places it would be natural
> to reset it.  However, it was always '1' in process_incoming_push_msg().
>=20
> Going for the timeout solution is a quick-fix as we need to have this
> issue solved before the 2.3 beta releases.  If anyone have a better=20
> solution, please submit a patch and we can drop this one.
>=20
> To trigger this bug and to test this fix, configure a UDP enabled server
> with PKI (--tls-{client,server}, --key, --cert, --ca, etc) and with add
> some --push statements as well.  When the initial connection has been
> established, stop the openvpn client and reconnect.  The bug will result
> in server receiving and ignoring PUSH_REQUEST and the client will send
> these requests until stopped.  The result is that the connection cannot
> be re-established.  Two workarounds have been identified for this
> behaviour.  A) Add --explicit-exit-notify to the client config,
> or B) switch from UDP to TCP.  I did not manage to reproduce this on
> a single computer running both client and server, but running on separate
> computers over the Internet made it possible to trigger this issue.
>=20
>  src/openvpn/openvpn.h |    2 +-
>  src/openvpn/push.c    |    7 +++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)

Applied to master.

commit 5d4f5435a421299ed047485d8d99bdf9a0d22fd1
Author: David Sommerseth <davids@...1347...>
Date:   Sun Sep 9 03:30:46 2012 +0200

    Fix reconnect issues when --push and UDP is used on the server
=20=20=20=20=20=20=20
    Signed-off-by: David Sommerseth <davids@...1347...>
    Cc: James Yonan <james@...515...>
    Acked-by: Gert Doering <gert@...1296...>
    Acked-by: James Yonan <james@...515...>
    Message-Id: 1347154246-20143-1-git-send-email-dazo@...384...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7044



kind regards,

David Sommerseth


--------------enig8A77E3B6E1A91E196546FFA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlBPfhQACgkQDC186MBRfrqzZwCeI6pFb0VOS6zYQGZc78K4/u7H
GIUAn0E/9dhKvLf2yEnr9+ucGT26U5s+
=pwdx
-----END PGP SIGNATURE-----

--------------enig8A77E3B6E1A91E196546FFA7--

