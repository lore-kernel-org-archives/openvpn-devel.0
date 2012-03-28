MIME-Version: 1.0
In-Reply-To: <4F72CE7E.90704@...1114...>
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
	<1332797200-9295-7-git-send-email-alon.barlev@...277...>
	<4F72CE7E.90704@...1114...>
Date: Wed, 28 Mar 2012 11:03:43 +0200
Message-ID: <CAOazyz1+EhRwVUhjm5SSQ9_s8+=5MxMT3ptkt89Pv+jmvY4RZg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 6/6] cleanup: ~0 is too large for 32bit
 ipv4 address
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

now to the list...

On Wed, Mar 28, 2012 at 10:40 AM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 26/03/12 23:26, Alon Bar-Lev wrote:
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> ---
>> src/openvpn/route.c | =C2=A0 =C2=A02 +- 1 files changed, 1 insertions(+)=
, 1
>> deletions(-)
>>
>> diff --git a/src/openvpn/route.c b/src/openvpn/route.c index
>> bf7af63..608403b 100644 --- a/src/openvpn/route.c +++
>> b/src/openvpn/route.c @@ -268,7 +268,7 @@ init_route (struct route
>> *r, const struct route_option *ro, const struct route_list *rl) { -
>> const in_addr_t default_netmask =3D ~0; + =C2=A0const in_addr_t
>> default_netmask =3D 0xffffffff;
>
> Please can you explain more in detail why this change is needed? =C2=A0In=
 my
> perspective, using ~0 is safer as it will always set all bits - no matter
> the size of default_netmask.
>
> And there are many more places in in source code where ~0 is used to
> provide that netmask. =C2=A0I would like to see some consistency, rather =
to
> just fix warnings which appears on some platform(s).
>
> In general, if you can provide a more verbose description why the patch
> is written in the commit messages, it will also help the review process.
> =C2=A0Most of us are not that skilled in reading others mind ;-)

Hmmm....
First there is a warning... :)
And I don't like warnings...

The explanation is that ipv4 is always 32bit, while ~0 can be either
32bit or 64bit depends on toolchain.
~0 should be used only if indeed the variable is 32bit/64bit by
architecture, this is not the case with ipv4.

0xffffffff as-is is valid ipv4 address/netmask...

I found only this warning, if there are more places, I guess these
needs to be fixed as well. So if you agree to the above, I will find
the other places.

Alon.

