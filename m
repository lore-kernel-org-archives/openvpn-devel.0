MIME-Version: 1.0
References: <20210513064416.212-1-lstipakov@...277...>
In-Reply-To: <20210513064416.212-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 4 Jun 2021 13:38:41 -0400
Message-ID: <CAKuzo_hfQifKQGxX9zUNv861mjiiiPxJw+me-iPf_ZkgNJovvg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] contrib/vcpkg-ports: add pkcs11-helper
 port
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

On Fri, May 14, 2021 at 10:31 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> From: Lev Stipakov <lev@...515...>
>
> pkcs11-helper is a dependency library used by OpenVPN.
> So far it has been built only by mingw.
>
> Since we're making MSVC build system a first class citizen,
> we need to build depencencies with MSVC, which we do with vcpkg.
> All dependencies are in vcpkg official repo, expect pkcs11-helper.
>
> This provides vcpkg port for building pkcs11-helper.
>
> Example usage:
>
>  vcpkg --overlay-ports=<openvpn>\contrib\vcpkg-ports install pkcs11-helper

Part of the changes here -- especially that of config-win32-vc.h
should go upstream to pkcs11-helper isn't it? In fact it may have to
be added to config-win32-vc.h.in as the former is a generated file.

Was it rejected upstream and we have to maintain this ourselves?

Also the patch adding the RFC 7512 (pkcs11: URI) serialization is
applied in openvpn-build as well. Adding a patch inside a patch
already makes it so hard to read/review and keep current, and now
having the same in two places would add to that burden.

Is there any real advantage of building openvpn.exe directly from here
as opposed to from openvpn-build? Anyway, for Windows releases we need
more than openvpn.exe.

Selva

