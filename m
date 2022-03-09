Date: Wed, 9 Mar 2022 11:39:53 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <767119891.38652.1646822393261@...2642...>
In-Reply-To: <20220308230621.1532809-1-heiko@...2662...>
References: <20220308230621.1532809-1-heiko@...2662...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] add support for --dns option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net

Acked-By: Frank Lichtenheld <frank@...2641...>

I have reviewed this on Github already and had no further issues.

> Heiko Hund <heiko@...2662...> hat am 09.03.2022 00:06 geschrieben:
>=20
>=20=20
> As a first step towards DNS configuration in openvpn and a unified way
> to push DNS related settings to clients in v2 and v3, this commit adds
> support for parsing the new --dns option. Later commits will add support
> for setting up DNS on different platforms.
>=20
> For now, --dns and DNS related --dhcp-option can be used together for
> smoother transition. Settings from --dns will override ones --dhcp-option
> where applicable.
>=20
> For detailed information about the option consult the documentation in
> this commit.
>=20
> Signed-off-by: Heiko Hund <heiko@...2662...>

Gr=C3=BC=C3=9Fe,
--
Frank Lichtenheld

