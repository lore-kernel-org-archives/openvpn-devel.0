References: <20181130135641.11533-1-gert@...1296...>
 <20181130135641.11533-3-gert@...1296...>
 <5e07f322-7d84-7758-8f46-f579579bd45d@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ebd4c068-6046-81d5-9763-ec5dec8cdddb@...2080...>
Date: Wed, 12 Dec 2018 23:50:20 +0100
MIME-Version: 1.0
In-Reply-To: <5e07f322-7d84-7758-8f46-f579579bd45d@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uWF2OcqLxgIHhv59WBMuFJgx7w1sozcGY"
Subject: Re: [Openvpn-devel] [PATCH 3/3] uncrustify openvpn/ sources
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uWF2OcqLxgIHhv59WBMuFJgx7w1sozcGY
Content-Type: multipart/mixed; boundary="N8NVLyu8kZWGX1xSl9IWFLA2cC3bx1jTY";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ebd4c068-6046-81d5-9763-ec5dec8cdddb@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] uncrustify openvpn/ sources
References: <20181130135641.11533-1-gert@...1296...>
 <20181130135641.11533-3-gert@...1296...>
 <5e07f322-7d84-7758-8f46-f579579bd45d@...2181...>
In-Reply-To: <5e07f322-7d84-7758-8f46-f579579bd45d@...2181...>

--N8NVLyu8kZWGX1xSl9IWFLA2cC3bx1jTY
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 12/12/2018 12:33, Antonio Quartulli wrote:
> I know we want to get "uncrustity-clean", but maybe we can tweak some
> options to comply with my remarks above? if not...well...uncrustify will
> decide for our codestyle ;P

Now I spotted your feedbacks, way too late :(  Sorry about that!

As I walked through this file, I thought this is better keeping it
out-of-the-loop for a few more weeks.  The code now is mostly compatible wi=
th
the _current_ uncrustify.conf available in the ./dev-tools, which is a good
step forward from the current state.  And I considered the current result
acceptable for now.

I do see my uncrustify run have some weird disagreements in
src/openvpn/push.c, where it wants to indent all the switch case parts one
more level.  Not sure why this didn't hit Gerts run though, this change does
seem appropriate to our CodeStyle wiki page.  My uncrustify also disagrees =
in
src/openvpn/buffer.c:474, where gc_addspecial(...) gets the space between
'void' and '(free_function)' removed.  Otherwise there is nothing unexpected
(including the change in src/openvpn/ssl.c already mentioned in the "PATCH
applied" mail).  But this can all be related to uncrustify versions and bugs
there.   I'll try to get a newer version built and see what happens then.

But I think we just need to accept that we can only push uncrustify to some
degree towards our desired coding style and then to accept the minor gaps to
our view of full perfection.  Telling contributors to "run your changes
through uncrustify before sending patches" will definitely help.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--N8NVLyu8kZWGX1xSl9IWFLA2cC3bx1jTY--

--uWF2OcqLxgIHhv59WBMuFJgx7w1sozcGY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcEZCsAAoJEIbPlEyWcf3yeSMQAKjItjwaMZyQP+1aUbsnSum0
tVQ1ISRDqXAPAphke1gTp3V5ovNwnXFcY3Nib/bM/3T6CGCCX+0rb3OqzDc6e2yE
smMKa7aD+mB/d0Zw5UbnknGWZ8RK0Av2WW+fItVA+iotluZ+qf/mZaikXC4qykqd
gV6jWgDLgmxWsVqzeDd44XtpYMXigdidoEZ8LO/aEi1+8pX87/qpqAjBzASRrcf4
TjU1jD4Ckdeou0BLcZczV4UlPpRmgyo3AbemW8ioT8LQdeEsOo9YnAqq97JhgCtA
npA6qfQZYgQvRFmChkF6zUgivh6qwq+NjlCuNcQ24lLyzrLyxB5a7byJcfHyOFB/
kA4eU/j1vrjA9cubiIuDJPFmjhJ7B7ljNvKOXBbh88xmkMwEnqO3M0z2PbeUgecZ
WOa5s4hCTG+YRzqbDtwCCPbvYMOQjY6UhSjrmtXMUp6ZUEKQk8ghNeca/WJj4aqX
0Nane9ujcJHnVOGbyEj7TvWYiy6YSjWbxKjhne+BxvQuGTrstmFCDADJot4pSONl
kbRYtQpdP4r6yn5rXCtJoTF2VAO7V8St8kjSeqG2h8UzNW6jPBAp+zGq5TYJkeSV
JDdFt01MgKlLTyHaeIpxX7EsxhOM0G41XyGSe+NfiHptY+Vz0D9e99I9h5KSpKcm
Afd+f5x+4JnL9ETGHhD2
=sLrc
-----END PGP SIGNATURE-----

--uWF2OcqLxgIHhv59WBMuFJgx7w1sozcGY--

