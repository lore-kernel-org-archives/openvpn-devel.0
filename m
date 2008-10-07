Message-ID: <9e0cf0bf0810071356j22282035j707e1d78770b6ee6@...278...>
Date: Tue, 7 Oct 2008 23:56:04 +0300
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <750B64C66078B34D918257A1AC004DB20544A2@...1132...>
MIME-Version: 1.0
References: <750B64C66078B34D918257A1AC004DB205441F@...1132...>
	<9e0cf0bf0809242210x74696837w126ea5caddede127@...278...>
	<750B64C66078B34D918257A1AC004DB2054440@...1132...>
	<9e0cf0bf0809271144i170c0805uadac7b428223fa7b@...278...>
	<9e0cf0bf0810071208i32b10997l72d25fe1490c6f@...278...>
	<48EBBE38.2030700@...334...>
	<750B64C66078B34D918257A1AC004DB20544A2@...1132...>
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

Binaries are at [1].

It is not enough to test it on client, we need to verify that the
validation works correctly on both ends, as capi has different policy
for servers and clients.

Alon.

[1] http://alon.barlev.googlepages.com/openvpn-mscapi-test-1.tar.bz2

On 10/7/08, Jason R. Coombs <jaraco@...1130...> wrote:
> Faidon,
>
>  If you send me a binary build for Windows 32-bit, I'll test it against expired
>  and revoked certs.  I presume I don't need a server configured for this test;
>  it should fail client side before attempting to connect?
>
>
>  Jason
>
>
>  -----Original Message-----
>  From: Faidon Liambotis [mailto:paravoid@...334...]
>  Sent: Tuesday, 07 October, 2008 15:53
>  To: Alon Bar-Lev
>  Cc: Jason R. Coombs; openvpn-devel@lists.sourceforge.net
>  Subject: Re: [Openvpn-devel] [PATCH v4] Use CryptoAPI CA store (was Re: [PATCH
>  v3] Use CryptoAPI CA store)
>
>
> Hi,
>
>  Alon Bar-Lev wrote:
>  > On 9/27/08, Alon Bar-Lev <alon.barlev@...277...> wrote:
>  >>  I prefer to receive patches...
>  >>  Anyway, this is not exactly what I meant.
>  >>  Please review latest head.
>  >>  I did not test this, but it should be correct now as far as the
>  >>  changes are concerned.
>  >>  It may not work as the validation process was never tested.
>  >
>  > Any news?
>  Thanks for reviving this. I built it and tried it and seems to work.
>  I didn't test with revoked or expired certificates, however.
>
>  As for warnings there's just a trivial one:
>         cryptoapi.c:429: warning: passing arg 2 of `d2i_X509' from
>                          incompatible pointer type
>
>  Regards,
>  Faidon
>
> -------------------------------------------------------------------------
>  This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
>  Build the coolest Linux based applications with Moblin SDK & win great prizes
>  Grand prize is a trip for two to an Open Source event anywhere in the world
>  http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
>  Openvpn-devel mailing list
>  Openvpn-devel@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>
>

