Date: Sun, 29 Jul 2018 09:43:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180729074314.GR55859@...1296...>
References: <789ad4be-2cb0-9af9-1d3f-7d1a9c05a1ab@...2137...>
 <20180727192636.GK55859@...1296...>
 <330e6498-78e9-c6f2-de16-3ae207fe26c7@...2137...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cmxQ2a0XYZsSJXeB"
Content-Disposition: inline
In-Reply-To: <330e6498-78e9-c6f2-de16-3ae207fe26c7@...2137...>
Subject: Re: [Openvpn-devel] Set interface metric instead letting it on auto
 (OS choice) when we have redirect-gateway present to enforce the desired
 effect for IPv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: s7r <s7r@...2137...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--cmxQ2a0XYZsSJXeB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jul 29, 2018 at 04:46:14AM +0300, s7r wrote:
> Sorry - I have missed this information because I thought it's irrelevant
> and it should apply to _any_ operating system, if it is to be applied at
> all. The OS where I experienced the behavior is Windows 10 Enterprise
> (64 bit) all up to date with OpenVPN community version 2.4.6-l602, vpn
> client running in UDP mode.

Only Windows exhibits this funkiness.  Other OSes just do what they
are told - "here's the most specific route, go and use it".

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--cmxQ2a0XYZsSJXeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbXXASAAoJEB2Cnv7KVigSGh4MAK2stV9TzFDYLClWwC08eN2E
Ogr/wg+6HinfxhKxSp/vk8No5RIeWBvCvhq17+dfs5uqxUJfBY6/pjX0mf8p4+7v
KH9KSfMdVQhvCCqTgeGD1l2nQUMiMFPuW2eGRVubExR7uom5KQVGLQyTkCkrQ3K/
5Q3koMZXPOyg9cSsIgKUXt2HSfQ3hImB5k+z3ibioNQJ39FOFHLXgmr80h3ckYX4
9t1hAQos0jBJK9Ll8HPHSpJbqwEh2WiEFmjRs38JR3BxCSpGI76VTxaN/nS9Mgbn
cOI69RpuqHSRR2cXWfMaWBxG58QfQD5it21X27H0ITB23PYwz8sQBmbSSpKmTd29
cE8gL26X9STGrb+7hrzi5SGGFua6+ObymkIVfxOHPBD9bWAZovUK8WTPLk57sf+j
RhpKcjsxbOH2qA+LGweXt7ZryHgOJo/M6YePbmQBDvzPIjQq9m8OV/0HT5mfakhx
UFFLLfvuHwMJQivJR/WlE5O7J4mxT+HsBbqy3MXqzg==
=wdxX
-----END PGP SIGNATURE-----

--cmxQ2a0XYZsSJXeB--

