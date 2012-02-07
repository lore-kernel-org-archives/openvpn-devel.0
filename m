Date: Tue, 07 Feb 2012 14:05:49 +0100 (CET)
From: g.esp@...260...
Message-ID: <b70a1279-dd13-4e20-b075-b178f84e5a95@...1545...>
In-Reply-To: <20120207102413.GQ13929@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] configure patch for MacOS 10.7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net



----- Mail original -----
> De: "Gert Doering" <gert@...1296...>
> =C3=80: openvpn-devel@lists.sourceforge.net
> Envoy=C3=A9: Mardi 7 F=C3=A9vrier 2012 11:24:13
> Objet: [Openvpn-devel] configure patch for MacOS 10.7
>
> Hi,
>
> I'm forwarding this "as-is", as I do not have enough understanding of
> autoconf to say whether this is necessary, or "the right fix" - but
> anyway, I've been told that this is needed to make our configure
> behave on MacOS 10.7.
>
> gert
>
> --

Adding AC_LANG_SOURCE where it is required is the right fix. I made that fi=
x on other packages.
This is not specific to MacOS, that just depend on the autoconf version ins=
talled on the system.

With autoconf-2.68 installed and running autoreconf on a package produce wa=
rning where AC_LANG_SOURCE is missing.
That look to be done properly (I haven't tested the patch)

Gilles

