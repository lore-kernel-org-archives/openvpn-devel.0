Message-ID: <9e0cf0bf0810091019k30444b16h24a5b3e20966930f@...278...>
Date: Thu, 9 Oct 2008 20:19:00 +0300
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <9e0cf0bf0810090934v771e710eod0d328eea9f0619a@...278...>
MIME-Version: 1.0
References: <750B64C66078B34D918257A1AC004DB205441F@...1132...>
	<9e0cf0bf0809242210x74696837w126ea5caddede127@...278...>
	<750B64C66078B34D918257A1AC004DB2054440@...1132...>
	<9e0cf0bf0809271144i170c0805uadac7b428223fa7b@...278...>
	<9e0cf0bf0810071208i32b10997l72d25fe1490c6f@...278...>
	<48EBBE38.2030700@...334...>
	<750B64C66078B34D918257A1AC004DB20544A2@...1132...>
	<9e0cf0bf0810071356j22282035j707e1d78770b6ee6@...278...>
	<750B64C66078B34D918257A1AC004DB20544AF@...1132...>
	<9e0cf0bf0810090934v771e710eod0d328eea9f0619a@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4] Use CryptoAPI CA store (was Re:
	[PATCH v3] Use CryptoAPI CA store)
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
Content-Disposition: inline
To: "Jason R. Coombs" <jaraco@...1130...>
Cc: openvpn-devel@lists.sourceforge.net

New binaries at [1], it should also print the validation status.

[1] http://alon.barlev.googlepages.com/openvpn-mscapi-test-2.tar.bz2

On 10/9/08, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Please note that the other side should detect the expiration.
>  Hence, if you revoke the client certificate the server should report
>  this and vice versa.
>  Please also make sure that both sides using the same functionality.
>
>
>  On 10/9/08, Jason R. Coombs <jaraco@...1130...> wrote:
>  > Alon,
>  >         I've tested the client functionality and the basic functionality works great
>  >  (not testing against expired or revoked certificates).
>  >
>  >         I then created a test for expired certs (incorrectly) by specifying an
>  >  expired _client_ certificate.  Curiously, OpenVPN did not complain about the
>  >  expired client certificate, but rather proceeded to attempt a connection with
>  >  it (which subsequently failed to establish TLS I suspect because the server
>  >  didn't have the corresponding public cert).  So I think I may have discovered
>  >  a limitation of the pre-existing cryptoapicert function.
>  >
>  >         So to recap:
>  >
>  >         Cryptoapicert client mode: fails to verify expired cert.
>  >         Cryptoapica client mode: works!
>  >         Cryptoapica client mode expired/revoked cert: untested
>  >         Cryptoapica server mode: untested
>  >
>  >         I'm in a conference this week, but will continue to test as time permits.
>  >
>  >
>  >  Jason
>  >
>  >  -----Original Message-----
>  >  From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>  >
>  > Sent: Tuesday, 07 October, 2008 16:56
>  >  To: Jason R. Coombs
>  >
>  > Cc: Faidon Liambotis; openvpn-devel@lists.sourceforge.net
>  >  Subject: Re: [Openvpn-devel] [PATCH v4] Use CryptoAPI CA store (was Re: [PATCH
>  >  v3] Use CryptoAPI CA store)
>  >
>  >  Binaries are at [1].
>  >
>  >  It is not enough to test it on client, we need to verify that the
>  >  validation works correctly on both ends, as capi has different policy
>  >  for servers and clients.
>  >
>  >  Alon.
>  >
>  >  [1] http://alon.barlev.googlepages.com/openvpn-mscapi-test-1.tar.bz2
>  >
>  >  On 10/7/08, Jason R. Coombs <jaraco@...1130...> wrote:
>  >  > Faidon,
>  >  >
>  >  >  If you send me a binary build for Windows 32-bit, I'll test it against
>  >  > expired
>  >  >  and revoked certs.  I presume I don't need a server configured for this
>  >  > test;
>  >  >  it should fail client side before attempting to connect?
>  >  >
>  >  >
>  >  >  Jason
>  >  >
>  >  >
>  >  >  -----Original Message-----
>  >  >  From: Faidon Liambotis [mailto:paravoid@...334...]
>  >  >  Sent: Tuesday, 07 October, 2008 15:53
>  >  >  To: Alon Bar-Lev
>  >  >  Cc: Jason R. Coombs; openvpn-devel@lists.sourceforge.net
>  >  >  Subject: Re: [Openvpn-devel] [PATCH v4] Use CryptoAPI CA store (was Re:
>  >  > [PATCH
>  >  >  v3] Use CryptoAPI CA store)
>  >  >
>  >  >
>  >  > Hi,
>  >  >
>  >  >  Alon Bar-Lev wrote:
>  >  >  > On 9/27/08, Alon Bar-Lev <alon.barlev@...277...> wrote:
>  >  >  >>  I prefer to receive patches...
>  >  >  >>  Anyway, this is not exactly what I meant.
>  >  >  >>  Please review latest head.
>  >  >  >>  I did not test this, but it should be correct now as far as the
>  >  >  >>  changes are concerned.
>  >  >  >>  It may not work as the validation process was never tested.
>  >  >  >
>  >  >  > Any news?
>  >  >  Thanks for reviving this. I built it and tried it and seems to work.
>  >  >  I didn't test with revoked or expired certificates, however.
>  >  >
>  >  >  As for warnings there's just a trivial one:
>  >  >         cryptoapi.c:429: warning: passing arg 2 of `d2i_X509' from
>  >  >                          incompatible pointer type
>  >  >
>  >  >  Regards,
>  >  >  Faidon
>  >  >
>  >  > -------------------------------------------------------------------------
>  >  >  This SF.Net email is sponsored by the Moblin Your Move Developer's
>  >  > challenge
>  >  >  Build the coolest Linux based applications with Moblin SDK & win great
>  >  > prizes
>  >  >  Grand prize is a trip for two to an Open Source event anywhere in the world
>  >  >  http://moblin-contest.org/redirect.php?banner_id=100&url=/
>  >  > _______________________________________________
>  >  >  Openvpn-devel mailing list
>  >  >  Openvpn-devel@lists.sourceforge.net
>  >  >  https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>  >  >
>  >  >
>  >  >
>  >
>  >
>

