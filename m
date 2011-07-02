MIME-Version: 1.0
In-Reply-To: <20110701205610.GA4992@...1474...>
References: <20110701205610.GA4992@...1474...>
Date: Sat, 2 Jul 2011 09:42:54 +0300
Message-ID: <CAOazyz2thLv=NURM89wXEHFb6rNWju5QtsL8LWqVoJFWXN4tnQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Builing OpenVPN for Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Bertrand Jacquin <beber@...1472...>
Cc: David Sommerseth <davids@...1347...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Please ask these stuff on the list.

1. You should use i686-w64-mingw32 for 32bit.

2. NSI build is not supported for cross compile, there openvpn
developers prefer to use their own build system in order to produce
the installer.

3. As openvpn is not modular, you must compile your self the tap
driver and sign it, most people are not interested in that. A better
alternative would have been to provide asigned .MSI for the tab driver
and embed it into the openvpn .MSI.

Alon.

On Fri, Jul 1, 2011 at 11:56 PM, Bertrand Jacquin <beber@...1472...> wrote:
>
> Hi,
>
> I'm tring to build openvpn from sources for Windows (x32 & x64) from
> with gentoo toolchain (i686-pc-mingw32 x86_64-w64-mingw32) but I face to
> some issue like how to sign drivers and why is there many nsi files like
> :
>
> beber@...1473... /data/build/src/openvpn $ find . -name setpath.nsi | xar=
gs sha1sum
> c379b947d55e49ad7496d89c1e002986a367d572 =C2=A0./gen/nsi/setpath.nsi
> c379b947d55e49ad7496d89c1e002986a367d572 =C2=A0./win/setpath.nsi
> c379b947d55e49ad7496d89c1e002986a367d572 =C2=A0./install-win32/setpath.nsi
> beber@...1473... /data/build/src/openvpn $ find . -name openvpn.nsi | xar=
gs sha1sum
> 5c9c4d360c188017475e26d3a524d54deeee23b4 =C2=A0./gen/nsi/openvpn.nsi
> 1f00a55d49551487307c644214830a67ba55f6ea =C2=A0./win/openvpn.nsi
> 5c9c4d360c188017475e26d3a524d54deeee23b4 =C2=A0./install-win32/openvpn.nsi
>
> Why do theses files are duplicated ?
>
> Thanks
>
> --
> Beber

