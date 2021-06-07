MIME-Version: 1.0
References: <20210513064416.212-1-lstipakov@...277...>
 <CAKuzo_hfQifKQGxX9zUNv861mjiiiPxJw+me-iPf_ZkgNJovvg@...278...>
 <CAGyAFMVsxv8fRFJD+zivivR9ugtJQoxCrf3_XF9f+eaetF8wyQ@...278...>
 <CAKuzo_jCE7zsxU64+20A28PuWoBDQawOHgGotiYJJ1XsyxsF_A@...278...>
In-Reply-To: <CAKuzo_jCE7zsxU64+20A28PuWoBDQawOHgGotiYJJ1XsyxsF_A@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 7 Jun 2021 10:34:36 +0300
Message-ID: <CAGyAFMUGwv6r-xxjw0te4P-a8k2aJ0zxPmegZ5eDDbx7yLxZSQ@...278...>
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> It has a long (6 years and counting)  history and may never get merged...
>
> https://github.com/OpenSC/pkcs11-helper/pull/4
>
> We could look into incorporating it into our own pkcs11 glue code
> (pkcs11.c etc.). Not sure whether it really needs access to any
> innards of pkcs11-helper.

Sounds reasonable. I don't know much about pkcs11 so let's wait for volunteers.

> At the same time, pkcs11-helper is a separate library so anything
> required to build it doesn't belong to openvpn repo, does it? Ideally
> native (msvc) build on Windows it should work like on Linux/Unix
> platforms -- have all dependencies satisfied independently and then
> just "configure" and build.

I agree. In 2.6 we're going to have vcpkg manifest with the list of
dependencies:

https://github.com/schwabe/openvpn/blob/dco/vcpkg.json

"dependencies": [
    "cmocka",
    "lz4",
    "openssl",
    "lzo",
    "tap-windows6",
    "ovpn-dco-win"
]

All those dependendencies (except ovpn-dco-win) have ports in vcpkg upstream,
so we just list those and let vcpkg do the rest.

Since pkcs11-helper (and ovpn-dco-win) have no support in vcpkg upstream,
we have to maintain ports ourselves.

We could:

 1)  move ports to openvpn-build. I don't think this is a good
solution, because that would
require Windows developers to clone another repo, which is needed for
building installers.
This looks like a wrong thing for me to do.

 2) move ports and the rest of Windows-specific stuff, such as
openvpnmsica, into openvpn-windows
repo. This is something to consider, assuming that this repo also
would take care about MSI (and NSIS?)
stuff and have openvpn as a submodule.

 3) do nothing and have those ports as part of openvpn repo. vcpkg
supports "ports-overlay" , so
I see nothing wrong or "hacky" with this approach. I see you point
about having dependencies build scripts
as part of openvpn repo. However in this case script is fairly trivial
and mostly consists of boilerplate code:

https://github.com/lstipakov/openvpn/blob/dco180521/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake

To my understanding this part of openvpn is fairly static, so I don't
expect much maintenance burden for it, if any. In any case I
volunteer to take care of it.

 4) submit pkcs11-helper and ovpn-dco-win ports to vcpkg upstream and
then remove those from openvpn.

We could do that after doing release with vcpkg as dependencies
manager, so we'll have a good use case.
I can volunteer for that.

-- 
-Lev

