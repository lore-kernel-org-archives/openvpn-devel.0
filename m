Date: Fri, 25 Dec 2020 20:39:50 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20201225193950.GZ976@...1296...>
References: <20201220105430.GP976@...1296...>
 <CACDCbPrvwmEGyAt1C4pVmzmCi0p-7nWkBqmDgDZAR00Bw6S8Zg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="v3Zc+y8YAsfCoUQ2"
Content-Disposition: inline
In-Reply-To: <CACDCbPrvwmEGyAt1C4pVmzmCi0p-7nWkBqmDgDZAR00Bw6S8Zg@...278...>
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Greg Cox <gcox@...1057...>
Cc: openvpn-devel@lists.sourceforge.net

--v3Zc+y8YAsfCoUQ2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 20, 2020 at 07:06:57PM +0000, Greg Cox wrote:
> So IMO, 1-2 are fundamental, 3-5 are
> wishlist/consideration/extensions/ideas, use or ignore as you see fit:
> * Make the ability for receiving messages on a client as described.
> Enabled by default, maybe selectively disable-able because someone will
> think it's spammy, but I'd almost suggest not allowing it.
> * Make the ability to send a user a message via management.  Enabled by
> default, maybe selectively disable-able as a safety mechanism / make
> someone "key the mic to speak."

These two can be done with the proposed "echo msg..." mechanism (and
suppressed with "pull-filter ignore echo" already today, and possibly
with buttons to-be-added in the GUIs).

> * Make the ability to 'wall' a message out to all connected users in one
> command, e.g. 'wall "server going down in 5 mins"' or something like that.

This is an interesting challenge.  Parts of openvpn client might assume=20
that a PUSH_REPLY is only seen at initial or renegotion time, so sending
a message with the proposed mechanism ("PUSH_REPLY echo msg server shutdown=
")
might trigger surprising effects.

It might just work.

But it can not be triggered from the server via client-connect scripts/
files/plugins as those are gone.  Maybe it can be triggered from the
servers-side management interface.  Not sure.


> * Make the ability to 'post' a message for some amount of time, e.g.
> 'wallpost 60m "server going down at 1700"'  Sending a message gets someone
> who is connected now, but misses the user who connects 2m after I go
> through the list of users and I stop looking.  So, this would hang around
> and pop a message to everyone connected now, plus each new connection, for
> the next 60m.

This is something outside "openvpn core", more tied to your client-connect
scripts/plugins on the server.  Put messages with an expire date "somewhere"
(database, filesystem, ...) and on connect, find everything that is still
valid and generate 'push "echo msg..."' messages accordingly.

> * Add an option ala --[no-]use-expired-certs.  When true, proceed like you
> do today; when false, if certs are expired, have the client feed itself a
> message via this mechanism to popup that your certs are expired, so a user
> knows right away what's wrong.  It'd be a spammy option if it tried to te=
ll
> you what to do, so I'm keeping the idea simple and generic.

Interesting idea :-) - not sure what to do about this one.  Since all
"major" GUIs already look at the log file, and present warnings in some
form to the user, maybe this is more a GUI task - if we warn about
"cert might be expired" AND then there is a AUTH_FAILED response,=20
change that warning (or even "all warnings logged") into a popup window?

Related but slightly different problem.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--v3Zc+y8YAsfCoUQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJf5kAFAAoJEB2Cnv7KVigScBIL+wRjIseACY5RqrloRSwC9ox5
ZxRZfRUrYfJxAar6OwhoJPi3V5wDKg7VqUjJnW9udUKLgdTCb99W65dzy7wkhfT3
mmvVzxoplGFChlggOx2t81KRo2djamSV9PzRTVrNimaJjMjZKG45MTzQQfoZOz1j
+aO1ML9ivH599ESyuyAVNmLJXbbBy69YZj6iOVKAqwEdf6Sg2R4LCGggYWZ8k7PC
BervqMF9ST1g6HhOWucCbfJh4fGELqBlRbktFLNNe/689T7/UAJcSSHqw/U9ET/q
m9HaADEArcYx47CfCOwfz89lrrILpyQbRtX5vretSOjrzigoCrGCEIgSOmwGJfzL
fiWIDcYlVur/v327T3Ka9F5g4ronnmeQ5wGtB9Kq6FTdLuSdOceJ/vLt/x9xfTIj
Kbr/+xc118ESXR8437ltfoaBxBlwd0TZV8dog1+vwi3mCu9L3sCf8dxuNQTsV+ok
nfooVjABIJiu7NwXIWis9vTpP5kHsh+8QASccYXjuA==
=CpJt
-----END PGP SIGNATURE-----

--v3Zc+y8YAsfCoUQ2--

