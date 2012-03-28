Message-ID: <4F72DD9F.3030300@...1114...>
Date: Wed, 28 Mar 2012 11:45:03 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1332616557-15727-1-git-send-email-alon.barlev@...277...>
	<CAOazyz3p-pZ=Sbmomnr2b9431hFxsxjte_P7ucSCAA4gJBpC_Q@...278...>
	<CAOazyz02u3u-_Bsb9yPKb2LJ5RyvnN6jwYQLRA68VHMO8DAvHQ@...278...>
In-Reply-To: <CAOazyz02u3u-_Bsb9yPKb2LJ5RyvnN6jwYQLRA68VHMO8DAvHQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] build: rename bool->obool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/03/12 11:32, Alon Bar-Lev wrote:
> On Sat, Mar 24, 2012 at 9:21 PM, Alon Bar-Lev <alon.barlev@...277...>
> wrote:
>> On Sat, Mar 24, 2012 at 9:15 PM, Alon Bar-Lev
>> <alon.barlev@...277...> wrote:
>>> PPC architectures and conflict with stdbool.h.
>>> 
>>> basic.h defines a type 'bool' that conflicts with the altivec 
>>> keyword bool which has to be fixed upstream, see bugs[1][2].
>>> 
>>> [1] https://bugs.gentoo.org/show_bug.cgi?id=293840 [2]
>>> https://bugs.gentoo.org/show_bug.cgi?id=297854
>>> 
>>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- 
>>> src/openvpn/basic.h              |    6 +- src/openvpn/buffer.c
>>> |   38 ++++---- src/openvpn/buffer.h             |   80
>>> ++++++++-------- src/openvpn/clinat.c             |    4 +- 
>>> src/openvpn/console.c            |   22 ++-- src/openvpn/console.h
>>> |    4 +- src/openvpn/crypto.c             |   34 ++++---- 
>>> src/openvpn/crypto.h             |   30 +++--- 
>>> src/openvpn/crypto_backend.h     |    2 +- 
>>> src/openvpn/crypto_openssl.c     |    6 +- 
>>> src/openvpn/crypto_polarssl.c    |    4 +- src/openvpn/error.c
>>> |   24 +++--- src/openvpn/error.h              |   16 ++-- 
>>> src/openvpn/event.c              |   16 ++-- src/openvpn/fdmisc.c
>>> |    4 +- src/openvpn/fdmisc.h             |    4 +- 
>>> src/openvpn/forward.c            |   10 +- src/openvpn/forward.h
>>> |    4 +- src/openvpn/fragment.c           |    2 +- 
>>> src/openvpn/fragment.h           |    8 +- src/openvpn/gremlin.c
>>> |    8 +- src/openvpn/gremlin.h            |    2 +- 
>>> src/openvpn/helper.c             |    2 +- src/openvpn/init.c
>>> |   70 +++++++------- src/openvpn/init.h               |   16
>>> ++-- src/openvpn/interval.c           |    4 +- 
>>> src/openvpn/interval.h           |   12 +- src/openvpn/list.c
>>> |   14 ++-- src/openvpn/list.h               |   16 ++-- 
>>> src/openvpn/lzo.c                |    8 +- src/openvpn/lzo.h
>>> |    6 +- src/openvpn/manage.c             |   86
>>> +++++++++--------- src/openvpn/manage.h             |   56
>>> ++++++------ src/openvpn/mbuf.c               |    4 +- 
>>> src/openvpn/mbuf.h               |    6 +- src/openvpn/misc.c
>>> |   54 ++++++------ src/openvpn/misc.h               |   30
>>> +++--- src/openvpn/mroute.c             |   24 +++--- 
>>> src/openvpn/mroute.h             |   10 +- src/openvpn/mtcp.c
>>> |   18 ++-- src/openvpn/mtcp.h               |    2 +- 
>>> src/openvpn/mtu.c                |    6 +- src/openvpn/mtu.h
>>> |    8 +- src/openvpn/multi.c              |   60 ++++++------ 
>>> src/openvpn/multi.h              |   54 ++++++------ 
>>> src/openvpn/ntlm.c               |    2 +- src/openvpn/occ.c
>>> |    2 +- src/openvpn/occ.h                |    2 +- 
>>> src/openvpn/openvpn.c            |    2 +- src/openvpn/openvpn.h
>>> |   48 +++++----- src/openvpn/options.c            |   84
>>> +++++++++--------- src/openvpn/options.h            |  190
>>> +++++++++++++++++++------------------- src/openvpn/otime.c
>>> |    6 +- src/openvpn/otime.h              |   18 ++-- 
>>> src/openvpn/packet_id.c          |   22 ++-- 
>>> src/openvpn/packet_id.h          |   22 ++-- 
>>> src/openvpn/pf-inline.h          |   10 +- src/openvpn/pf.c
>>> |   32 +++--- src/openvpn/pf.h                 |   14 ++-- 
>>> src/openvpn/ping.h               |    2 +- src/openvpn/pkcs11.c
>>> |   22 ++-- src/openvpn/pkcs11.h             |   16 ++-- 
>>> src/openvpn/platform.c           |   16 ++-- 
>>> src/openvpn/platform.h           |   12 +- src/openvpn/plugin.c
>>> |   16 ++-- src/openvpn/plugin.h             |   12 +- 
>>> src/openvpn/pool.c               |   22 ++-- src/openvpn/pool.h
>>> |   18 ++-- src/openvpn/proto.c              |    2 +- 
>>> src/openvpn/proto.h              |    2 +- src/openvpn/proxy.c
>>> |   26 +++--- src/openvpn/proxy.h              |    8 +- 
>>> src/openvpn/ps.c                 |   12 +- src/openvpn/ps.h
>>> |    2 +- src/openvpn/push.c               |   26 +++--- 
>>> src/openvpn/push.h               |    8 +- src/openvpn/pushlist.h
>>> |    2 +- src/openvpn/reliable.c           |   36 ++++---- 
>>> src/openvpn/reliable.h           |   32 +++--- src/openvpn/route.c
>>> |   68 +++++++------- src/openvpn/route.h              |   32
>>> +++--- src/openvpn/session_id.h         |   10 +- 
>>> src/openvpn/shaper.c             |    4 +- src/openvpn/shaper.h
>>> |    4 +- src/openvpn/sig.c                |   10 +- 
>>> src/openvpn/sig.h                |    6 +- src/openvpn/socket.c
>>> |   94 ++++++++++---------- src/openvpn/socket.h             |
>>> 98 ++++++++++---------- src/openvpn/socks.c              |    8
>>> +- src/openvpn/socks.h              |    6 +- src/openvpn/ssl.c
>>> |   88 +++++++++--------- src/openvpn/ssl.h                |   16
>>> ++-- src/openvpn/ssl_backend.h        |    8 +- 
>>> src/openvpn/ssl_common.h         |   26 +++--- 
>>> src/openvpn/ssl_openssl.c        |   12 +- 
>>> src/openvpn/ssl_polarssl.c       |    8 +- 
>>> src/openvpn/ssl_polarssl.h       |    2 +- 
>>> src/openvpn/ssl_verify.c         |   26 +++--- 
>>> src/openvpn/ssl_verify.h         |   10 +- 
>>> src/openvpn/ssl_verify_openssl.c |    4 +- src/openvpn/status.c
>>> |   12 +- src/openvpn/status.h             |   10 +- 
>>> src/openvpn/tun.c                |  104 ++++++++++---------- 
>>> src/openvpn/tun.h                |   52 +++++----- 
>>> src/openvpn/win32.c              |   28 +++--- src/openvpn/win32.h
>>> |   26 +++--- src/plugins/defer/simple.c       |    9 +-- 107
>>> files changed, 1208 insertions(+), 1213 deletions(-)
>> 
>> Well,
>> 
>> As usual, Mailing list limitation for large/complex patches inhibit
>> proper communication.
>> 
>> Patch can be found/pulled from github[1].
>> 
>> [1]
>> https://github.com/alonbl/openvpn/commit/bec27e73f534e97c3d24d63680a0dfe6824aef2a
>
>> 
> David,
> 
> Your opinion regarding this one?

I'm in the process of reviewing all bool usage in OpenVPN.  I've gone
through ~60% of the source code where bool variables are used.

The reason for that review is that I'm not convinced adding our own
boolean type is the way to go.  I'd much rather see us using stdbool.h
and keep using the bool for pure boolean purposes.  Where flags needs to
be used, it makes much more sense to either use a uint type, or maybe
even typedef a flag_t type.

So far I've only seen bool being abused for flags in setenv_sockaddr(),
setenv_in_addr_t() and setenv_link_socket_actual().


So bottom line is, please hold a bit more until I manage to complete
reviewing the boolean usage properly.


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9y3Z0ACgkQDC186MBRfrr7nwCgjdjh6qKk3M0XRIMTTAdugCa7
LicAn3A8lqKEEpIxtGdAd9fj5kwXa99P
=uAB7
-----END PGP SIGNATURE-----

