Date: Wed, 5 Oct 2022 22:19:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yz3muBEdbTSo13qX@...1296...>
References: <20220909195902.2011798-1-arne@...1227...>
 <20220909195902.2011798-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KwCa5xyY/3RqvWap"
Content-Disposition: inline
In-Reply-To: <20220909195902.2011798-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Use buffer to prepare
 protocol-flags push-reply
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

--KwCa5xyY/3RqvWap
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 09, 2022 at 09:59:01PM +0200, Arne Schwabe wrote:
> The current approach of checking a string buffer is a bit clunky and
> also not very extensible. Refactor this by collecting the flags in
> a buffer.

I think that this one is obsolete, aka, already included in

commit 179b3728b71013413885e453e477997f5a396f78
Author: Arne Schwabe <arne@...1227...>
Date:   Wed Sep 14 18:50:41 2022 +0200

    Implement exit notification via control channel

    Patch v4: rebase, use a buffer for the code that prepares the push reply

can you confirm?

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

--KwCa5xyY/3RqvWap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjPea3AAoJEB2Cnv7KVigS4JkL/0/Zil7dBLj/QTf3artKASbo
5JZdcN6HbQbN4IhE39vle6GH72eIv8JAzPsn3c5vfbIM9WeM5apVIj/6/3Sr24o5
xuPKbU7HfLdN4IlkFyFZaFy4wG+97GexrlLRr1EKKgEndcHkhnTe2Y4iVz2OQe1T
jsA/8YSJa9MQGkfBAm2Kf8EGgtZdcBmLJAykxhZSh+N0dqzz2um2KEqYEh0bmWMh
5ZTrpWOUCOuR6Y5daXlzn66BsEOMge3hV8agRshqPWn0KHnq0L5/BLEj/Krb7HvE
aKZDaMVx/xJbbDmrYnBzvXqr8UuBk04R1WCq8JM4X/FeqND4uPjtEQx4HPZsoS4Y
BmNOeS8ZBRUcf1gk67s17YBA2Pu7xDWnCbNETzhJveIrxUoFKh4vjiFNfNvOafKz
LVHR4AqL7yKAbRiLYQb2fDF/NBa3BkyWFD7QH38orXc8qWh8Ky5DBeLZmbLY6MIE
sUi4uHVxW0VL3LpurbSDp52EaW2iYb4z5gZYNem5fg==
=eZ5M
-----END PGP SIGNATURE-----

--KwCa5xyY/3RqvWap--

