Date: Wed, 26 Oct 2022 14:45:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y1kr4zYWRP29K2G2@...1296...>
References: <20221019224642.11178-1-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NUIQXeQ6jnKDDSM+"
Content-Disposition: inline
In-Reply-To: <20221019224642.11178-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH for 2.5/2.6] Purge auth-token as well
 while purging passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--NUIQXeQ6jnKDDSM+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 19, 2022 at 06:46:42PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> Starting from commit e61b401a auth-token is saved in a separate struct
> from auth-user-pass and is not cleared when ssl_purge_auth() is called.
> This makes "forget-passwords" sent to the management
> interface or "--management-forget-disconnect" option not to work
> as expected.

I am not sure I can go along with Arne's ACK here - the reason is that
ssl_purge_auth() is not only called from man_forget_passwords() (where
I'm totally fine with the change) but also on received EEN from the
server ("RESTART"), and this patch changes behaviour here.

Without patch:

 - server pushes token (secret-based --auth-gen-token)
 - server is ctrl-c'ed by admin, sends RESTART
 - client calls server_pushed_signal() -> ssl_purge_auth()
     forgets username + password, but not token
 - server is restarted, same token secret
 - client reconnects, sends token, is allowed in

With patch:

 - server pushes token (secret-based --auth-gen-token)
 - server is ctrl-c'ed by admin, sends RESTART
 - client calls server_pushed_signal() -> ssl_purge_auth()
     forgets username + password, but not token
 - server is restarted, same token secret
 - client reconnects...

	2022-10-26 14:38:58 SIGUSR1[soft,server-pushed-connection-reset] received,=
 process restarting
	2022-10-26 14:38:58 Restart pause, 5 second(s)
	...
	Enter Auth Username:

   ... and asks for a username.

I think this is not what this patch is expected to do, and would irk
a lot of my 2FA users (that are currently happy that I can restart the
openvpn server without them all having to do 2FA again).

There is a theoretical way to avoid this (server needs to send RESTART,P),
but the --explicit-exit-notify code on the server has no way to trigger
this, so it's not helping.

This also affects --management-forget-disconnect (obscure option of
the day), which, I think, should not forget tokens either - but I do
not have a strong opinion here.  I think OpenVPN should retain tokens
on disconnect due to "network change" or whatever, but then, I have
no idea when we'd want to use this option in the first place.

=20
The two other places where this is called (SIGUSR1 AUTH FAIL with
"auth-retry interact" and man_forget_passwords() should be fine with
forgetting tokens - I think "AUTH FAIL" already does this (in some
other code path).


I agree with the intent on the patch (Feature-ACK), and would suggest
to call "ssl_clean_auth_token()" directly from "man_forget_passwords()"
instead.  This will catch your (valid) use-case without impacting=20
other users of ssl_purge_auth().

May I also suggest to add a comment to ssl_purge_auth() to clearly
state that "this function never clears auth tokens" so we remember
next time?

thanks,

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--NUIQXeQ6jnKDDSM+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjWSvjAAoJEB2Cnv7KVigS6/0MAJpbaPzLmYpJhlALD5d/ZA+d
QC5vPj8XCkuSCIZEs6YlQ0NVJZYMCYj70H/c7HJqT0m4SpMLcxu4MrKRm5Dq3lRh
CSA3skECLbxxHU8m5QEgq6WDyi8ndzn5xwsjnXXB7EUZ2QQoNGyVm0oBscMj3Rgc
dq0VPCiwAAtsCsqIfasHehYqyZZmEjszRC04TiNqIGK3Fur6a6y7Kl1anS5s7Zpk
pQ1MOIxZTafTzuxBdQ1Z1o17KugDaNX9p30pRS5wYbuilMCrJ77qTT92PA3r7v4L
lDCg+Cr+zObL4HON4Guxkm04vVcoL9aGur0rnfzCh//wrArNVgUN0iBcATZr942J
QGUwmXmRHLglERfMuZcfbs4IBTcgljBUb9806Ny1V16xTlSkne88CIofPJNXT2xm
+ocSVocSXylT1YjygDkiSHAMFJ+pZNc6flxhscqE1YLLS3OL5ASBuvWujrLc8I1C
N+tg0HLq8oOqWCyIpwJIvphLAQ5KUxmLjkzzJ22rTg==
=jD+I
-----END PGP SIGNATURE-----

--NUIQXeQ6jnKDDSM+--

