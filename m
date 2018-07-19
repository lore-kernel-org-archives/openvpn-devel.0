References: <B09CA954-FCB8-4362-912F-F43DDD7DC59C@...438...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <c3d60209-2756-6327-102f-2adaae81dc8d@...2181...>
Date: Thu, 19 Jul 2018 10:57:58 +0800
MIME-Version: 1.0
In-Reply-To: <B09CA954-FCB8-4362-912F-F43DDD7DC59C@...438...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UU4ZvOpbn6CYf7IVcd7k1jxtUeVjQsTR5"
Subject: Re: [Openvpn-devel] Fix for NetBSD with subnet topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adam <adam@...438...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UU4ZvOpbn6CYf7IVcd7k1jxtUeVjQsTR5
Content-Type: multipart/mixed; boundary="sHTrby8kPvCW0yF2aKbpMFUarh5XADCBo";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Adam <adam@...438...>, openvpn-devel@lists.sourceforge.net
Message-ID: <c3d60209-2756-6327-102f-2adaae81dc8d@...2181...>
Subject: Re: [Openvpn-devel] Fix for NetBSD with subnet topology
References: <B09CA954-FCB8-4362-912F-F43DDD7DC59C@...438...>
In-Reply-To: <B09CA954-FCB8-4362-912F-F43DDD7DC59C@...438...>

--sHTrby8kPvCW0yF2aKbpMFUarh5XADCBo
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Adam,

thanks for your change.

could you please submit the patch in proper git format so that it can be
easily applied?

You can create a patch like that by using the "git format-patch" command
after you have commited your changes (you need to clone the git
repository for that).

After creating the patch file, you can send it with either "git
send-email" (preferred) or by attaching it to your email.

Please, don't forget the "Signed-off-by:" line at the end of your commit
message.

On top of all this, is there a way to explain in a few words why this is
now required (should go in the commit message)? Or "it just works this way"?


Thanks a lot.

Regards,

On 18/07/18 22:33, Adam wrote:
> Greetings,
>=20
> It turns out, NetBSD needs similar handling of subnet topology for tun in=
terfaces as OpenBSD does.
>=20
> Here is a patch to fix the issue (against OpenVPN 2.4.6):
>=20
>=20
>=20
>=20
>=20
> Kind regards,
> Adam
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
Antonio Quartulli


--sHTrby8kPvCW0yF2aKbpMFUarh5XADCBo--

--UU4ZvOpbn6CYf7IVcd7k1jxtUeVjQsTR5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltP/jYACgkQB6U8WA7y
zXSlhQ/+PZEy3VMuIhBn0Mi8UFvz+t1yOcz3jlgFFY3xat0rAIz61GMmhjpzMEh8
y79F9tyMPOIrwwhXs+GDlOHW6K8XCjaVKh3amV9ALcIWw8LkH1sp0ZgQX8gvusgQ
75rwHnCXmCmwPPZ2NyH/z+CE3ji5MmfzKvUeRSi7hSFMtPzMM13VTqino2BI4IN4
rl3UG5o8j/YffnsI3ka+Fb7oVSL0B+qa8EIxmLs++LfzlkdEmwZaZ/CxoTHnMc10
VkTE2hEQnZOJ1Y557VTeF+cjQwmjiyGkHG5GOYxD16Hb9QFG9G9b96h4HcXUCX3o
hs86tPpyECUtsB9EeRxhgBQAJ9/vYGU2pwUEFZPxrPKCebqlMWpRTthsXFCWX3QY
iNOL69KeeIZYj3KceRLAN5wkBGpALWYgxnJ5LNxpiYkXBfXm0Y3j9Q2/Bd3suafu
i0XH8Es5jHGgohEUb2wfNi2a+sdSmkhrGwa9c/0pq461hQLExfefi3tx4uD/JGyt
4VNIQD6/haz3Z9MYBrh5EO30q0avgMmu+SuJ6rEUxBrmE8dJGNHQ4iN7D+To4ioF
al9x81yTjZk+V+hfueHvpEQ9V8y5mVrd9pYX7zwGYVjNPLIIwpp/xGr78McQPm9Z
u12eX7laVTa7Lru+AuCzosIRDsMWecjumOf+defz4GJLHE7w8pk=
=qUHY
-----END PGP SIGNATURE-----

--UU4ZvOpbn6CYf7IVcd7k1jxtUeVjQsTR5--

