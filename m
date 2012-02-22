MIME-Version: 1.0
In-Reply-To: <20120222082619.GJ7024@...1296...>
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
	<4F44A1A3.8050007@...515...>
	<20120222082619.GJ7024@...1296...>
Date: Wed, 22 Feb 2012 10:57:43 +0200
Message-ID: <CAOazyz2KcQp-bZw7WsbKJooJV9qWdY3q5UFqKeeXReAYi604Vw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [build] Windows build test
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

2012/2/22 Gert Doering <gert@...1296...>:
> Hi,
>
> On Wed, Feb 22, 2012 at 10:04:51AM +0200, Samuli Sepp=C3=A4nen wrote:
>> > While you at it, please try to explain me why we need Visual Studio bu=
ild... :)
>> I guess for building the TAP-driver.
>
> No, that one builds fine with the msys build environment and the
> windows ddk.
>
> We have Visual Studio because James was afraid that mingw would stop
> being supported, leaving us without a viable build environment. =C2=A0Whi=
ch
> turns out to be not a real problem (yet), given that mingw64 seems to
> be supported quite well.

I never knew this is the reason. And I follow this project for long time.
Mingw w64 is a great project.
If it is the only reason, we should stop supporting visual studio, supporti=
ng
only autoconf build system, get rid of Microsoft specific noise.
If in future there will be no MSVC alternative the effort will be
smaller to migrate
once than maintaining the implementation until that point.

Alon.

