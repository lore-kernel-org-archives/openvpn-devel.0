MIME-Version: 1.0
References: <20211015175330.15760-1-selva.nair@...277...>
In-Reply-To: <20211015175330.15760-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 18 Oct 2021 10:09:47 +0300
Message-ID: <CAGyAFMXOARGy6qiftdN9WXi-saaiWB1nONMCrEo+3wLDpCTooQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix some more wrong defines in
 config-msvc.h
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
To: Selva <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> Not sure where these came from, but here goes:

According to git blame, those dates back to 2012:

https://github.com/OpenVPN/openvpn/commit/4b1a82db0975088dbfe69c2a97f0a96ef=
972b2a4#diff-f17c6f8c8df2b2934b574e407cbde107338969c6898ce8e8965dc289ae979f=
c6R97

> S_IRUSR =3D 0 --> _S_IREAD
> S_IWUSR =3D 0 --> _S_IWRITE

MSFT docs says that:

"If a value other than some combination of _S_IREAD and _S_IWRITE is
specified for pmode=E2=80=94even if it would specify a valid pmode in anoth=
er
operating system=E2=80=94or if any value other than the allowed oflag values
is specified, the function generates an assertion in Debug mode and
invokes the invalid parameter handler, as described in Parameter
Validation."

I tried Debug build with --status but haven't seen any assertions.
Anyway, it is clear that passing 0 was incorrect.

> Should fix Trac #1430 but untested (I do not have a setup at hand for msv=
c build).

If you push your branch to GitHub, it will kick off GitHub Actions
build which produces MSVC-built artifacts.

Built and tested locally, works as expected - status file is created
without "readonly" attribute.

Acked-by: Lev Stipakov <lstipakov@...277...>

