Date: Tue, 5 Apr 2022 17:02:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YkxaHo8ZC31uJ38v@...1296...>
References: <20220402070902.30282-1-a@...2181...>
 <20220402070902.30282-4-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2KL6WSUUsu8pmze3"
Content-Disposition: inline
In-Reply-To: <20220402070902.30282-4-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 3/7] networking: implement net_iface_new
 and net_iface_del APIs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--2KL6WSUUsu8pmze3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 02, 2022 at 09:08:58AM +0200, Antonio Quartulli wrote:
> +int
> +net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
> +{
> +    struct argv argv =3D argv_new();
> +
> +    argv_printf(&argv, "%s link del %s", iproute_path, iface);
> +    openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip link del fai=
led");
> +
> +    argv_free(&argv);

On "failure to remove something" we generally do not hard-abort right
away but just report the error, and continue with cleaning up things.

So maybe net_iface_del() should do the same thing?

(See "undo_ifconfig_ipv4()", for example, or most other close_tun() related
openvpn_execve_check() calls)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2KL6WSUUsu8pmze3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiTFoeAAoJEB2Cnv7KVigStasMAKiqyjmoTMWsbCA725UIBbX6
KCGmn+4ooQ6liX6B50J2U3CYpfeLBrP5etqUo9ulZJhnzHFVplSoVnyRRqz6kNiq
YK1BKYgXqT5V7mgwr+QpssDU8V37twReRkStTZxsB5qo/J4TZdE8xnrWAVi8QrT9
ylvedMu7IlImo/sw3/tdBc/Vi6HdJFYCrh9kcnrbp28l+9BYYLY1oQVMIFZd9Hdo
4E/xoHdEtTaQNwYGR/6OE1iwqLqCwlDkHsGhSGGzujWrLmye1VzIcCDZk69uRzKv
+nPZpE3fAbCaf2PZ3T5vArKPfsnQ7fRAEjgJXatEEAcs1A5NsKzDirY4vR2ahzZQ
lsVjiKfdr+/8Fdnkp3xtOhDHqXGVqU0dpn7MTrL5lhD3T8HZ+KHSRmKkC69VZaQj
RXfbEuyHifGMYmXeTCK0yjQ9XbMKarmqSGeNI65YgRTEIsyvlwmQ9Zx8R3jCBG7d
dw/GMlXuCJ0Oxw+qJZYwzpoNmiDOM9LE4KGKPJrDyg==
=zMHI
-----END PGP SIGNATURE-----

--2KL6WSUUsu8pmze3--

