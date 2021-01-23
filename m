Date: Sat, 23 Jan 2021 13:11:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210123121134.GC976@...1296...>
References: <20210121133929.20186-1-gert@...1296...>
 <35ab1fab-6943-e734-789a-94d7cdbeb25a@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="26XwpMuZoZ9c1owL"
Content-Disposition: inline
In-Reply-To: <35ab1fab-6943-e734-789a-94d7cdbeb25a@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Make OPENVPN_PLUGIN_ENABLE_PF failures
 FATAL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--26XwpMuZoZ9c1owL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 22, 2021 at 08:02:42AM +0100, Arne Schwabe wrote:
> I agree to make this "fixed" in a way that doesn't involve refactoring
> of pf code that is later removed anyway. I don't think the refactoring
> early affects this. It has been probably broken even earlier.

So I got myself nerdsniped into understanding when and how this broke.

Tested v2.4.10, and that works nicely when ENABLE_PF fails - it logs a
warning, and that's it.  No instance restart, no crash.

The instance restart is introduced here:

commit 492e42d35f141346fe21b3e984ed1bd86e5aac40
Author: Steffan Karger <steffan@...1856...>
Date:   Wed Nov 1 23:03:40 2017 +0100

    pf: reject client if PF plugin is configured, but init fails
=20=20=20=20
    This changes the behavior for pf plugins: instead of just not initializ=
ing
    the firewall rules and happily continuing, this now rejects the client =
in
    the case of an (unlikely) failure to initialize the pf.

... which, back then, actually worked.  Sort of - it aborts the client
connection, but since it does so very early (before TLS_FINAL), the client
is never told, and times out eventually.

Sat Jan 23 12:45:48 2021 us=3D726018 2001:608:0:814::f000:21 PLUGIN_CALL: p=
lugin function PLUGIN_ENABLE_PF failed with status 1: /home/gert/openvpn-pf=
test.git/sample/sample-plugins/defer/simple.so
Sat Jan 23 12:45:48 2021 us=3D726033 2001:608:0:814::f000:21 WARNING: faile=
d to init PF plugin, rejecting client.


So, git bisect time... and that leads to

$ git bisect good
c252dcc073155567c1982611ec6f065342909287 is the first bad commit
commit c252dcc073155567c1982611ec6f065342909287
Author: Arne Schwabe <arne@...1227...>
Date:   Fri Jul 3 11:55:06 2020 +0200

    Remove did_open_context, defined and connection_established_flag
...

which is somewhat nonobvious to me - but the call chain for the pf*context()
stuff is sufficiently "out of the norm" that it could very well be, changing
assumptions about "how do we know the state of a multi_instance" which=20
work well for all well-behaved paths, but not for the pf stuff.


That said, I think a "proper" fix might be to move the pf_init_context()
call to "when the instance is fully initialized and TLS has succeeded"
(so we can proper shut down the instance again).  Somewhere close to the
other plugin calls like "client-connect", and fail "as they do", if
needed.

But I do not intend to do that, just write up thoughts for reference if=20
we ever ask ourselves "what was the result of that investigation?" :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--26XwpMuZoZ9c1owL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgDBHMAAoJEB2Cnv7KVigSMxsL/A8uZyk6zPJ37xYKDjnve6Vg
+KODhy1Dx9WHrE1IkmHKrc/nHeprG1+6CzszJhdUCyakp5ta22N2SAqhJ2cEx10b
wygWSfUESe2fYv6KM7fJQkCtWEbWdLz7WXHUPe0wIjjJlv2tx/PF9TUgZrCgSxWq
P27+ScEwQ+rB8jzbIX5U75zlgAcFHnboKyv7Te1yC2H+VYAX3nWCHNQpHdEe+ZIx
uC8axzaYPXnwHI6U6BAgxmtLIdIjFChzicT3aEaEmwwY8nxe3hMz+EMwoSViuyC5
kZSatWeZHQLUyg5d8gu3ndBYeNrYLQnMQnjEGc6RXRK3wXfCOMZDw/BD6/Jsf+VS
qP9fIE2RspeQFvXeEpkbAeOeCDiFTbfPpJ4k0ynSNPpxZy5r6cGLbf0Iu9ulO9x4
at1I8ykQVLIBnHhaudStoj86YUPScexhtsllPL48pB/cfUOKVpjwDCOUoedXB6DZ
5Rp3LqOJ2eaT+wX7NIEDMD8GGwDC+XOk5QA6X5BCFQ==
=Uyf4
-----END PGP SIGNATURE-----

--26XwpMuZoZ9c1owL--

