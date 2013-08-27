Message-ID: <521C6546.2080203@...515...>
Date: Tue, 27 Aug 2013 11:37:26 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <kvb1ud$dbt$1@...1062...>
In-Reply-To: <kvb1ud$dbt$1@...1062...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn-build dep cache support
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
To: Josh Cepek <josh.cepek@...1085...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> The attached patch allows the openvpn-build system to create and use
> cache tarballs for dependencies, preventing them from being built every
> time (even when they haven't changed.) My VM build time went from ~12 to
> under 2 minutes with this feature.
>
>

Hi Josh,

This is a very welcome change - build errors that happen at the end of
the build are currently _very_ annoying. The patch merged fine and I'm
currently running some tests on it. If all goes well I'll push it to master.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


