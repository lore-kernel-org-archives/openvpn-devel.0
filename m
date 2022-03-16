From: Heiko Hund <heiko@...2662...>
Date: Wed, 16 Mar 2022 13:28:58 +0100
Message-ID: <2918495.nbWkrbPmRn@...2664...>
In-Reply-To: <20220312135810.242028-1-heiko@...2662...>
References: <20220308230621.1532809-1-heiko@...2662...>
 <20220312135810.242028-1-heiko@...2662...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Samstag, 12. M=C3=A4rz 2022 14:58:10 CET Heiko Hund wrote:
> +        name_ok =3D openvpn_snprintf(env_name, sizeof(env_name), "dns_se=
arch_domain_%d", i) && name_ok;=20

With some distance, I still like the &=3D version better from a readability=
 standpoint.
Even though it's a bit unclean.

Heiko



