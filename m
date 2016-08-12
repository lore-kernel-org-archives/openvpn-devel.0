References: <4489a66e-428f-493d-6dc9-1dde62c2c731@...2080...>
	<CAKuzo_jXCPDbsn24i4LcsqovVXGNaQuc-PtwwucnVDvwpMQgYg@...278...>
	<09fc522c-b33f-1c9b-9def-854ae3c07c62@...2080...>
	<CAKuzo_iC+gmgck4uY69k37tSMe-HAzn0uXJu7LwqxuMXP-Byxg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <da790cbb-c93d-cd00-0f78-96cf868115f9@...2080...>
Date: Fri, 12 Aug 2016 20:38:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iC+gmgck4uY69k37tSMe-HAzn0uXJu7LwqxuMXP-Byxg@...278...>
Subject: Re: [Openvpn-devel] autoconf/automake warnings
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/08/16 20:27, Selva Nair wrote:
>=20
> On Fri, Aug 12, 2016 at 6:30 AM, David Sommerseth=20
> <openvpn@...2080...=20
> <mailto:openvpn@...2080...>> wrote:
>=20
> On 12/08/16 03:14, Selva Nair wrote:
>>=20
>>=20
>> On Thu, Aug 11, 2016 at 2:50 PM, David Sommerseth=20
>> <openvpn@...2080...
> <mailto:openvpn@...2080...>
>> <mailto:openvpn@...2080...
> <mailto:openvpn@...2080...>>> wrote:
>>=20
[...snip....]
>=20
> If the Makefile.am in src/openvpnsrv has a build-target for the=20
> block_dns.c file which would just copy the source file to the=20
> openvpnserv/ directory ... would that work?
>=20
> Rough (not really tested) example is attached.
>=20
> This is incomplete but could be made to work with some changes.
> However, such a hackery is not needed in this particular case as
> one could simply replace $(top_srcdir)/src/openvpn/block_dns.c
> $(top_srcdir)/src/openvpn/block_dns.h in Makefile.am by=20
> ../../src/openvpn/block_dns.c ../../src/openvpn/block_dns.h and use
> the subdir-objects option without issues.
>=20
> But the problem is that, its not just these two files, we now have=20
> subdir source references in places like=20
> tests/unit_tests/plugins/auth-pam/Makefile.am as well. Replacing=20
> $(top_srcdir) by something like "../../../../..." in deeply nested=20
> directories would be error-prone and cumbersome. If/when more and
> more tests get added this is going to get only worse.

Agreed.  And the nesting will be a hassle with time anyhow - suddenly
someone tries to move a directory to a different subdir level, and all
hell breaks loose again.

> I would say ignore the subdir-objects warning for now and we can=20
> conditionally enable it when a version of automake that supports
> it without breaking use of variables in foo_SOURCES becomes widely=20
> available. In the mean time keep testing subdir-objects using a
> patched automake may be all that we can do.

I can live with that for now.  But it would be good to have a solution
before we get complaints from more bleeding edge distros (Fedora,
Arch, Ubuntu, openSUSE etc) that 'automake doesn't work any more' due
to our setup isn't modern enough.

I'll send a patch to ML fixing the LT_INIT stuff, that should work
just fine regardless of the subdir-objects option.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAleuF5AACgkQDC186MBRfrplnACfVvzPmHWhVTBLU42pqkMhIPIv
u7QAnjmO6pU83/SV9GCYZRnnzYLvV8eZ
=3DeHDo
-----END PGP SIGNATURE-----

