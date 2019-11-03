Date: Sun, 3 Nov 2019 21:46:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191103204613.GE40538@...1296...>
References: <20191103053148.18059-1-tom.ty89@...277...>
 <20191103182443.GC40538@...1296...>
 <20191103183351.GD40538@...1296...>
 <CAGnHSEn0jaM3u9LCXxArhQkL9ddZQ9UROOZ8+PXPf+oAwTyswg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8sQsHfNlXZNubEnG"
Content-Disposition: inline
In-Reply-To: <CAGnHSEn0jaM3u9LCXxArhQkL9ddZQ9UROOZ8+PXPf+oAwTyswg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] tun/iproute2: support 31-bit ipv4
 prefix (RFC 3021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom Yan <tom.ty89@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--8sQsHfNlXZNubEnG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 04, 2019 at 03:54:49AM +0800, Tom Yan wrote:
> While the commit message says "support" 31-bit prefix, this patch is a
> bug fix by nature. Whether one can actually uses a /31 subnet for
> *anything* (i.e. not just OpenVPN) pretty much depends entirely on the
> platform itself. This patch is needed simply because broadcast address
> does not "apply" in a /31 subnet, and having it set *prevents* it from
> working.=20

Understood (thought it would be more helpful if the commit message
said so :-) ).

> In fact, if openvpn tries to set the broadcast address with
> `+` instead of an explicit address calculated by itself, `ip` can
> handle it well. I do it with a prefix length check because I am not
> sure if there's a reason that `broadcast +` wasn't used instead.

I wasn't aware that there is a "broadcast +" setting, but I'm way
more tempted to just get rid of setting broadcast at all.  This is a
computer, it can do the math itself.

> Yeah the removal of the p2p topology was one of the reasons. It's
> actually the fact that ics-openvpn doesn't really parse point-to-point
> ifconfig that made me aware of this.

I wasn't aware of that, but since Arne is reading here, maybe he can
comment on it.  It's possible that the Android VPN API just does not
permit p2p mode, but wants a subnet.

Arne, any idea if /31 works on Android?


> I don't know anything about sitnl. Is it available only in 2.5/master?
> While I have also sent the equivalent fix for that, it's merely a
> "forwardport". I haven't actually used 2.5/master at all (unless
> ics-openvpn counts, while I don't see broadcast being set for any case
> on Android).

Yeah, master.  New functionality always has to go into master, and
2.4 backporting is only done under certain conditions (undisputed
bugfixes, long-term compatibility changes).

Adding conditionals is not a bugfix.  Removing the "broadcast" part
from "ip add" could be considered as such... it needs testing on=20
somewhat ancient Linux systems (I think we aim to support all=20
RHEL/CentOS releases that are still supported, which will definitely
cover "OLD!!").  But seriously I expect this to be totally unnecesary
historic cruft unless told otherwise.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--8sQsHfNlXZNubEnG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdvzyVAAoJEB2Cnv7KVigShQEL/j/u+jdSassd/TTEY4zuvWV9
IKmqHU3OgoDriJeCM6BX6YUn7G2n4qTeKVSOWz+Fb83by7A5nlHEjPxstUfEiByV
NM9JxKAKAqrFY404gl3vk+rpkrdiL/2n3GnHzJDSWoJNUX+OvMP8el5fDfPtfhxv
d+Ut6PueICtOjdPABpM28gB8iNeQvp7293XcuJELKQx7j/W/nv+oS9TVi9uiTOoG
h4eDuI1gVR+rt6ef6SK2DCu0ycNW+Nl0QU6bn4y/qIL8sdpDGYzvqbd4tf3t6o1p
I5xXKxtVgeuM3Enr00F/lSUK84GQ3eanRAz40LR9LLCGnSeWa1eJqeVd5vZNfzn1
Te+KoCfcnNj8zmGZEZ4RfOk//3ia00cOfkNuycZZKe+CdY/rbjWRLAkYX2GtrI4o
gYP7idGIActnyMJy3w0ebkdKg18Fe7iI3uRMq2XNsc4YSV+iw85I283vTgCzzbcq
LEvTrYpP1U2e/SGkVAcSFfhvjL6QQK+8IdOLkJ57KA==
=/2vm
-----END PGP SIGNATURE-----

--8sQsHfNlXZNubEnG--

