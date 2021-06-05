MIME-Version: 1.0
References: <20210513064416.212-1-lstipakov@...277...>
 <CAKuzo_hfQifKQGxX9zUNv861mjiiiPxJw+me-iPf_ZkgNJovvg@...278...>
 <CAGyAFMVsxv8fRFJD+zivivR9ugtJQoxCrf3_XF9f+eaetF8wyQ@...278...>
In-Reply-To: <CAGyAFMVsxv8fRFJD+zivivR9ugtJQoxCrf3_XF9f+eaetF8wyQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 5 Jun 2021 12:18:50 -0400
Message-ID: <CAKuzo_jCE7zsxU64+20A28PuWoBDQawOHgGotiYJJ1XsyxsF_A@...278...>
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Sat, Jun 5, 2021 at 11:43 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> Hi,
>
> > Part of the changes here -- especially that of config-win32-vc.h
> > should go upstream to pkcs11-helper isn't it? In fact it may have to
> > be added to config-win32-vc.h.in as the former is a generated file.
> >
> > Was it rejected upstream and we have to maintain this ourselves?
>
> it was accepted to upstream:
>
> https://github.com/OpenSC/pkcs11-helper/commit/1d33a743bc67cfeb62293bc75f1bf2949c8115bb
>
> However the latest release 1.27 was tagged in November, 2020. Either
> we switch to
> using master or maintain this change ourselves until 1.28 is out.

That's good to know. We can live with that I suppose.

> Or politely ask Alon
> to tag 1.28, for the sake of his good contributions to openvpn :)
>
> > Also the patch adding the RFC 7512 (pkcs11: URI) serialization is
> > applied in openvpn-build as well. Adding a patch inside a patch
> > already makes it so hard to read/review and keep current, and now
> > having the same in two places would add to that burden.
>
> I agree. Does anybody know if that patch is required (on Windows),
> why wasn't it merged (submitted?) to upstream and shall we try to
> submit it to upstream now?

It has a long (6 years and counting)  history and may never get merged...

https://github.com/OpenSC/pkcs11-helper/pull/4

We could look into incorporating it into our own pkcs11 glue code
(pkcs11.c etc.). Not sure whether it really needs access to any
innards of pkcs11-helper.

>
> > Is there any real advantage of building openvpn.exe directly from here
> > as opposed to from openvpn-build? Anyway, for Windows releases we need
> > more than openvpn.exe.
>
> IMO yes, at least from developers' perspective. While you need
> openvpn-build to make installers,
> it is not required (not when "standalone msvc build" patch is merged)
> for openvpn Windows development.
>
> pkcs11-helper is not a separate tool like, say, openvpn-gui or
> EasyRSA, but a real dependency of
> openvpn.exe, same as openssl. So I don't see reasons not to include it
> into build process,
> especially when it doesn't require much effort (and will require even
> less with 1.28).

At the same time, pkcs11-helper is a separate library so anything
required to build it doesn't belong to openvpn repo, does it? Ideally
native (msvc) build on Windows it should work like on Linux/Unix
platforms -- have all dependencies satisfied independently and then
just "configure" and build. Too much to ask?

Selva

