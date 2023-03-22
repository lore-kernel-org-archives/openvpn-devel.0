Date: Wed, 22 Mar 2023 14:13:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZBr/B38Irub8yT0b@...1296...>
References: <20230322113249.2039-1-lstipakov@...277...>
 <CAKuzo_iT15pQgAOVmr-00Jn4c7Yb_H-j28_S=GZ4_xKaFwLvaw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="McKMYjVWDa3Uca8F"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iT15pQgAOVmr-00Jn4c7Yb_H-j28_S=GZ4_xKaFwLvaw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Print DCO client stats on SIGUSR2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net

--McKMYjVWDa3Uca8F
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 22, 2023 at 09:03:02AM -0400, Selva Nair wrote:
> Can't we have a coarse timer that keeps the stats updated? It doesn't have
> to be frequent as this is just for information.

I can see why you do not like the current style - but doing this with
timers is something I'm not really happy with.

If nobody ever presses F2 / sends SIGUSR2, we spend useless going in and
out of the kernel to get statistics that nobody cares about.

*If* someone wants to see what happens, and sends SIGUSR2 in short=20
intervals ("ok, so we have 4 kbyte now, let's run $testprogram, and
see what the value is afterwards"), the counters printed will be=20
in accurate, because we've not polled the now-current numbers.


(For the status file stats, the writing-of-the file is timer triggered,
so then using the same event to poll the data makes sense)

> > +    status_printf(so, "TCP/UDP read bytes," counter_format,
> > c->c2.link_read_bytes + c->c2.dco_read_bytes);
> > +    status_printf(so, "TCP/UDP write bytes," counter_format,
> > c->c2.link_write_bytes + c->c2.dco_write_bytes);
>=20
> Same here --  have a place to read the total count from independent of dc=
o.

This is something the FreeBSD DCO counter patch introduced, and which
might not have been the best idea - I think the idea was "leave the userland
counters alone", but thinking about it, these should always be 0 anyway,
no?  So we could just overwrite them.


I tend to merge this patch "as is", because it did not introduce the
debatable way to do DCO counters - and come back later when we have all
platforms and features working and have a better understanding of the
code paths involved (like, --inactive) and then try to make it more nice.

(Yes, I know, good intentions and all that)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--McKMYjVWDa3Uca8F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkGv8HAAoJEB2Cnv7KVigSdsQL/jy7pizMTk3SlxYyr7U9zfVc
Lnn1F06JlwWMohg0Ev0xjtzWXUhNxbB8WaTJFGwngaLEQFgkIyi/m0J38RA41uLq
mZZZddV1NGHNlDKVXAzWYfllxC9ZQzny2LwE4GFLoYWkWf2PYraieSeXgD9EzFAv
cYIVgl2Q00+IRg4ncze/xGO8u8mSwO3D1H/7vvshhqnU4X9P3Lu9vFW7pzvHD+uT
XrFc7wHP6o2Y81tYpTU0HVzN5SATHAOTffw8lnjGuKJZQZl14BXYSTI+u48kZ3gt
jeii2dw5r/Lx64ANq5oXhwfKAnciVY+u3X0dTpKLl4FKX2fsrEhNF9zCeRlAu7K8
0gH9dyrORAOSA91I2OQRaJApTE88dBjBnnNqw9MQxS/pUt6kx5F3fsrH6INOGRIy
z3SVHKTZUJD1a1/TDgEDZ1sIZ8ubTNaetpzyTq9WF/Gqq9hv4JsQST3CMTaNCiak
+rJ00HZKP7sDI+bfZhg7Hl0gfVUzuWZI83CdqAlySA==
=oFFr
-----END PGP SIGNATURE-----

--McKMYjVWDa3Uca8F--

