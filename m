Mime-Version: 1.0 (1.0)
From: Marvin Adeff <volleynbike@...277...>
In-Reply-To: <20200713143426.GC1431@...1296...>
Date: Mon, 13 Jul 2020 10:31:05 -0700
Message-Id: <7B6AB61C-782B-4CE4-BC1D-F28CA763E318@...277...>
References: <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
 <20200623090252.GE1431@...1296...>
 <4f03e378-f327-21a6-9f11-fe06a42052b6@...1823...>
 <518ceb3d-e060-f777-f19f-4998b8d27170@...1227...>
 <3f6159de-c513-78d5-194c-989a8611c291@...1823...>
 <20200713061023.GK1431@...1296...> <20200713063303.GM1431@...1296...>
 <20200713065828.GN1431@...1296...>
 <9b4e2c49-8ef4-efb6-0b04-c273b077dc70@...1227...>
 <6B6A4240-A4F4-4388-BD1D-ABF049535351@...277...>
 <20200713143426.GC1431@...1296...>
Subject: Re: [Openvpn-devel] compatibility of 2.3 server with git master
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Thank you I will try this.=20

Marvin=20

Sent from my iPhone

> On Jul 13, 2020, at 7:34 AM, Gert Doering <gert@...1296...> wrote:
>=20
> Hi,
>=20
>> On Mon, Jul 13, 2020 at 07:23:59AM -0700, Marvin Adeff wrote:
>> I???m wondering if the opposite of this scenario has been tested, where =
the server is running 2.3.18 (on Linux) and a client running 2.5 (on Window=
s) tries to connect?
>=20
> It should work, but this is a "should".  It's hard enough to test all
> possible combinations of clients and features against git master, so we
> do not normally test current clients against out-of-service releases
> on the server.
>=20
> On the other hand we do not purposely break client-server protocol,=20
> so it *should* work.  It's just not regularily tested.
>=20
> If you test, and it breaks, please show client and server logs so we can
> fix it :-)
>=20
>=20
>> I know, I know, we should upgrade.  Unfortunately in this case OpenVPN s=
erver is running on an appliance that cannot be upgraded past Linux 2.6, an=
d I don???t think 2.4.x can run on Linux 2.6.=20
>=20
> You do not want to have an appliance that is running an ancient linux
> version connected to the Internet either...
>=20
> But besides that, compiling OpenVPN 2.4 should be no big problem - it is
> not very demanding regarding system environment or OpenSSL version.
>=20
> For OpenVPN 2.5 (git master) you'll need an update openssl library - but
> this is also not hard, you can compile it and install it to a non-default
> place ("/usr/local/openssl-1.1.1") and point OpenVPN's configure script
> at it.
>=20
> One of my test clients is FreeBSD 7.4, which stopped receiving updates
> in 2013 - but with a local openssl installation, it works fine, with
> git master  (this is sort of a "are we using fancy features that break
> older unixes now?" lithmus test, not something you want exposed on the
> Internet, or something I'd recommend).
> --=20
> "If was one thing all people took for granted, was conviction that if you=
=20
> feed honest figures into a computer, honest figures come out. Never doubt=
ed=20
> it myself till I met a computer with a sense of humor."
>                             Robert A. Heinlein, The Moon is a Harsh Mistr=
ess
>=20
> Gert Doering - Munich, Germany                             gert@...1296...

