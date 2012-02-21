MIME-Version: 1.0
In-Reply-To: <4F43BEB5.6050404@...1114...>
References: <CAOazyz34oFXrQ8vh5qXcEFPC3wA8Qhn7ivzLKasB=B9mOCKyZQ@...278...>
	<4F43BEB5.6050404@...1114...>
Date: Tue, 21 Feb 2012 18:12:25 +0200
Message-ID: <CAOazyz2rRpsKzitWS5bWe8Ug7ut=ODQy9PDkq7v4Aa7E1ygHHA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [RFC] openssl minimum supported version
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Tue, Feb 21, 2012 at 5:56 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> There might be similar restrictions related to autoconf/automake tools
> too. =C2=A0As James has some automation for the Access Server builds for =
those
> supported platforms, we must be sure we don't break that for him. =C2=A0F=
rom
> what I see, on a recent 5.7 box ...

No there is none.
Unlike other dependencies autotools dependencies are of development machine.
You should create tarball on newer machine then compile it on the
target platform.
Target platform may not have autotools installed at all.

The new build system will support >=3Dautoconf-2.60, automake>=3D1.10, libt=
ool>=3D2.2

Again, from experience generating tarball using these versions tends
to work well
on very old platforms.

Alon.

