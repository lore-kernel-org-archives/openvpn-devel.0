MIME-Version: 1.0
In-Reply-To: <20110530162036.GA11197@...1462...>
References: <20110530162036.GA11197@...1462...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Tue, 31 May 2011 13:47:34 +0200
Message-ID: <BANLkTimGaCouQO+XE9O=hJ2mkSs0oQh-hpJEW+=+_qAkD_92Pw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] USE_PF_INET6 by default for v2.3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, David Sommerseth <dazo@...384...>, Gert Doering <gert@...1296...>

On Mon, May 30, 2011 at 6:20 PM, JuanJo <jjo+ml@...410...> wrote:
> - put all #ifdef'd code in place, kill the cpp symbol,
> - thus in v2.3 it's not actually possible to --disable-ipv6 :)
>
> RATIONALE:
> =A0#1 some wacky compilers choke on #ifdef'd constructions for
> =A0 =A0concatenated strings, and given that:
> =A0#2 v2.3 has already transport ipv6 by default
> =3D> doesn't justify putting effort on #1 to keep USE_PF_INET6
> =A0 ifdef wraps.
>
> Signed-off-by: JuanJo Ciarlante <jjo+ml@...410...>
> <...snip...>

FWIW you can also peek at the diff at:
  https://github.com/jjo/openvpn-ipv6/commit/77fed9c07c1461cd926ab4e86c587c=
ac8414b957
  http://codereview.appspot.com/4564045/

Cheers,
--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

