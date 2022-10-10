Date: Mon, 10 Oct 2022 09:27:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y0PJSKGL0/ZMZG/3@...1296...>
References: <20221009130805.1556517-1-arne@...1227...>
 <202210091351.299Dpam7025642@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uqvQgyCxjBialogp"
Content-Disposition: inline
In-Reply-To: <202210091351.299Dpam7025642@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix OpenVPN querying
 user/password if auth-token with user expires
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--uqvQgyCxjBialogp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 09, 2022 at 03:51:36PM +0200, Gert Doering wrote:
> Recording David's and Heiko's ACK, they have done the stare-at-code
> and actual testing (I have run t_client tests, but they do not excercise
> this problem with my current test servers - need to add more variants).

Just for the records - testing this with 2.x OpenVPN as server seems
to be impossible using built-in --auth-gen-token or using the script
interface to --auth-user-pass-verify + --client-connect, because of
various reasons (--auth-gen-token does not even trigger when there is
no initial username, and the script approach interferes with TLS
username locking - patch for that on the list).

That said, I found a way to stage the server side, and can now confirm
that *without* this patch, the sequence

 - client without --auth-user-pass
 - server pushes --auth-token-user + --auth-token
 - client sends these as future username/password
 - token expire, servers sends AUTH_FAIL

will lead to

 - client stops, asking for "Enter Auth Username:" without the patch

 - client reverts to sending "no username+password" *with* the patch
    (the client declares this a "reconnect" and waits 5 seconds, but
     the connection will recover without user interaction)

(tested for both 2.5 and master)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--uqvQgyCxjBialogp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjQ8lIAAoJEB2Cnv7KVigS9zEL/RBPDPVHZtEW6SUhHQTSMwPs
4Nz78wAVZQUYWp7g5s5VoSiDpH8FNuHv6DX+XIJhm2CLrydvnW4zlViq11IR51YA
I7Xi3FTtLGb/mKLyvwTkhCJ0NNv74qY2BLq6oT6Df0JmFmp4XAg/6La7aVjdL/SM
9hrSqxxdtxUNC81QX9iN8k6XyBlFff20+cOSqu1zRMynBKNK8NlLBaFfouh/nYsj
Zj9Hepty5WjXR2OPSDOLiNg/a7Ru2Jt5kJ7xpUCdsW2HRYR/1YH02mL/J01jMg0t
3X25jaBDxh/KSK8MQIkzGxF4adrCLqzqkg1Ash2K9Kbla8NDSX5HDZUj0N5NMXLt
yc6dHpoTcxqbGQ8jOruwSS9idyYJg+gbJSr9Of/dDkU2bM0tT30zrcQG/hxvFRaN
f9bMVWd1plpwhcSXh0W5rao4EM47gIU8lb8x9swbMko5mS9uptILhQkJBmHWn66c
ZcIdQ6nA8qEgz1dVFEF1SuR62oVdclUciHRfaJ7jjA==
=d+ej
-----END PGP SIGNATURE-----

--uqvQgyCxjBialogp--

