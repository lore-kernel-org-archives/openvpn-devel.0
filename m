Date: Tue, 16 Aug 2022 11:33:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YvtkVb8uYifVdEOr@...1296...>
References: <20220514103717.235-1-timo@...2669...>
 <202208111003.27BA3jBP091528@...2054...>
 <YvoXzZNWGa49RJ6D@...1296...>
 <41d3a297-83f3-5b13-49f7-dd70b0d8daee@...2669...>
 <YvogFJdhB+8n3qrK@...1296...>
 <e7ad101d-4a46-72b2-7eec-5be5e8d636f4@...2669...>
 <YvokdcW8oF9ur/mm@...1296...>
 <CAA1Abx+YF51w6QQJaFqrNL9s3Q_Gp08jiZR7-WLsbTQaUqmZhA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4fmQ+PWSwNogiEaB"
Content-Disposition: inline
In-Reply-To: <CAA1Abx+YF51w6QQJaFqrNL9s3Q_Gp08jiZR7-WLsbTQaUqmZhA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: platform: Retain
 CAP_NET_ADMIN when dropping privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: Gert Doering <gert@...1296...>, Timo Rothenpieler <timo@...2669...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4fmQ+PWSwNogiEaB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 16, 2022 at 11:16:50AM +0200, Steffan Karger wrote:
> So I'm really not in favour of retaining CAP_NET_ADMIN "just in case".
> I would even like to be able to not retain it at all.

I hear what you say, and I support that line of thought.

Alas, with current Linux-DCO, we need this for fiddling all the DCO bits
(keys / key renewal! / peer-id / install/update peers), as this is done
via netlink, and netlink requires CAP_NET_ADMIN.

To get around that we'd need to find a communication channel to=20
(Linux-)DCO that does not require privileges after initial setup=20
("hey, DCO, give me a socket that does not need privileges") and=20
rewrite quite a bit...  I'm sure that Antonio will be thrilled by
that new challenge... :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--4fmQ+PWSwNogiEaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi+2RVAAoJEB2Cnv7KVigSYNEL/jVVbyWCjtYvaewcnqhMDFQa
SlB5AXsROeEpR4Zk2YMMu4jXmM3gPgpxw5YDN8q49zuiBSyBwnPrO7QQsVKha+KD
01cMtKQT9HaITojFP8d6VSQSQUy1vRVb6jh4MGXTV+iR+GgxGhbe/oM96aUXZITG
W6XHBHddKwbzIqIrp7fsPYatgFnV6F0HR1MoNI5pDkxkUoDOz2w5PZG9dqKaUPaw
O4Bu9tz7NYgv7iVgH0iJLAUEZ/TnxAQIWnQG9GB4s4q6BpHP75SAN5nEsJWpsEUN
f2XaHXUEzufXpTaef6reHDIz7yEUFXS2oDk/LXZeIgo59JvdzrFChWj5kBwsEiEX
Feswb2BUEsHFJiOTIpYNsHeCcfBXgW9G8JSbT44XiQhTJ/+zEJ2vK3OKxr9PnUrQ
1LpHEQL4qq6upept4bH4dPvaQwZpROXZHGlGcGrm7QB2xv7h6bCMaODnztw6nZBh
pcxvkTEu11yfHNW8oXPnyxnHGbOF/92G/5Ig7X7nQA==
=Hchv
-----END PGP SIGNATURE-----

--4fmQ+PWSwNogiEaB--

