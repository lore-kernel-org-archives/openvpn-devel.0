Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <17910477-83a7-9ca7-c388-3f164759e36b@...2080...>
Date: Tue, 20 Jun 2017 05:47:05 +0800
Message-Id: <0C28488A-E6E8-48AB-A3FB-D79707785C05@...2181...>
References: <20170619130507.13892-1-davids@...515...>
	<20170619131630.GK97029@...1296...>
	<17910477-83a7-9ca7-c388-3f164759e36b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] auth-token with auth-nocache fix broke
 --disable-crypto builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>


> On 19 Jun 2017, at 21:22, David Sommerseth <openvpn@...2080...> wrote:
>=20
> On 19/06/17 15:16, Gert Doering wrote:
>>=20
>> Somewhat ugly (is there no existing #ifdef ENABLE_CRYPTO block nearby
>> that we could hide this in?) but I need a clean tree tonight, and this
>> will fix things.  So, will to go with it.
>=20
> There are no other ENABLE_CRYPTO blocks in
> initialization_sequence_completed() [init.c:1375].  The alternative
> could be to put this #ifdef inside the delayed_auth_pass_purge() and
> make that function be "empty" without ENABLE_CRYPTO.  But as init.c is
> the only place this is called outside the ENABLE_CRYPTO scope, this is
> where my dice rolled.

Something I have been doing in the kernel code was to put this kind of bloc=
ks in the .h file where the function is declared: in case of CONSTANT not-d=
efined the function would be defined inline within the .h file with an empt=
y body. The assumption is that the corresponding .c file is not compiled in=
 this case.
This is usually quite clean and avoids having more and more ifdefs inside t=
he code. For example in this case it would result in:

#ifdef ENABLE_CRYPTO
void delayed_auth_pass_purge(void);
#else
void delayed_auth_pass_purge(void)
{
}
#endif

Obviously you=E2=80=99ll want to group multiple functions in the same ifdef.

This might be helpful to beautify (->make easy to read) several parts of th=
e openvpn code.

my 2 cents.

Cheers,


--
Antonio Quartulli




