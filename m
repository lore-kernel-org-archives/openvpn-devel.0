MIME-Version: 1.0
In-Reply-To: <4FAE87C1.6000509@...277...>
References: <4FAE87C1.6000509@...277...>
Date: Sat, 12 May 2012 21:29:17 +0300
Message-ID: <CAOazyz3pJ6xy_wVnsT13ZuMJipG0kK77EF-C5tK9dWKn4XwxDw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Properly detect OpenSSL version strings
 with numbers only
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
To: Simon Deziel <simon.deziel@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, the revision letter is indeed optional.

David,
Repository is at github...

On Sat, May 12, 2012 at 6:54 PM, Simon Deziel <simon.deziel@...277...> wrot=
e:
> whichopensslcnf failed to return the right cnf for:
>
> $ openssl version
> OpenSSL 1.0.1 14 Mar 2012
>
> Signed-off-by: Simon Deziel <simon.deziel@...277...>
> ---
> =C2=A0easy-rsa/2.0/whichopensslcnf | =C2=A0 =C2=A06 +++---
> =C2=A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/easy-rsa/2.0/whichopensslcnf b/easy-rsa/2.0/whichopensslcnf
> index 2226a8e..ccdaf50 100755
> --- a/easy-rsa/2.0/whichopensslcnf
> +++ b/easy-rsa/2.0/whichopensslcnf
> @@ -3,11 +3,11 @@
> =C2=A0cnf=3D"$1/openssl.cnf"
>
> =C2=A0if [ "$OPENSSL" ]; then
> - =C2=A0 =C2=A0 =C2=A0 if $OPENSSL version | grep -E "0\.9\.6[[:alnum:]]"=
 > /dev/null; then
> + =C2=A0 =C2=A0 =C2=A0 if $OPENSSL version | grep -E "0\.9\.6[[:alnum:]]?=
" > /dev/null;
> then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cnf=3D"$1/openssl-=
0.9.6.cnf"
> - =C2=A0 =C2=A0 =C2=A0 elif $OPENSSL version | grep -E "0\.9\.8[[:alnum:]=
]" >
> /dev/null; then
> + =C2=A0 =C2=A0 =C2=A0 elif $OPENSSL version | grep -E "0\.9\.8[[:alnum:]=
]?" >
> /dev/null; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cnf=3D"$1/openssl-=
0.9.8.cnf"
> - =C2=A0 =C2=A0 =C2=A0 elif $OPENSSL version | grep -E "1\.0\.([[:digit:]=
][[:alnum:]])"
>> /dev/null; then
> + =C2=A0 =C2=A0 =C2=A0 elif $OPENSSL version | grep -E "1\.0\.[[:digit:]]=
[[:alnum:]]?"
>> /dev/null; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cnf=3D"$1/openssl=
-1.0.0.cnf"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cnf=3D"$1/openssl.=
cnf"
> --
> 1.7.5.4
>
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

