References: <1470570245-28327-1-git-send-email-iam@...2070...>
	<17e0440a-d70c-0003-f18c-d21ae9ac3b95@...2080...>
From: ValdikSS <iam@...2070...>
Message-ID: <3329cad0-dabe-506a-6a03-a9fc0a158c1a@...2070...>
Date: Tue, 16 Aug 2016 19:29:08 +0300
MIME-Version: 1.0
In-Reply-To: <17e0440a-d70c-0003-f18c-d21ae9ac3b95@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="X8SgWlSnW8nuekQUq1DL7C28fiivGvoBo"
Subject: Re: [Openvpn-devel] [PATCH 1/3] Do not pass env for system commands
	on Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X8SgWlSnW8nuekQUq1DL7C28fiivGvoBo
Content-Type: multipart/mixed; boundary="KimFpS1wlrRBXSUl6cToXVDI7eP6vtmH2"
From: ValdikSS <iam@...2070...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <3329cad0-dabe-506a-6a03-a9fc0a158c1a@...2070...>
Subject: Re: [PATCH 1/3] Do not pass env for system commands on Linux
References: <1470570245-28327-1-git-send-email-iam@...2070...>
	<17e0440a-d70c-0003-f18c-d21ae9ac3b95@...2080...>
In-Reply-To: <17e0440a-d70c-0003-f18c-d21ae9ac3b95@...2080...>

--KimFpS1wlrRBXSUl6cToXVDI7eP6vtmH2
Content-Type: multipart/alternative;
	boundary="------------45675C3CF9CAB2A9B13EC9CF"

This is a multi-part message in MIME format.
--------------45675C3CF9CAB2A9B13EC9CF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 08/08/2016 11:34 AM, David Sommerseth wrote:
>
> On 07/08/16 13:44, ValdikSS wrote:
> > It's possible to have so much routes that they won't fit into stack
> > and execve would fail with E2BIG (Argument list too long).
>
> > This commit fixes this issue by not adding route information into
> > execve'd application env. --- src/openvpn/lladdr.c |  2 +-
> > src/openvpn/route.c  |  8 ++++---- src/openvpn/tun.c    | 12
> > ++++++------ 3 files changed, 11 insertions(+), 11 deletions(-)
>
> > diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c index
> > 57f447b..d537379 100644 --- a/src/openvpn/lladdr.c +++
> > b/src/openvpn/lladdr.c @@ -58,7 +58,7 @@ int set_lladdr(const char
> > *ifname, const char *lladdr, #endif
>
> > argv_msg (M_INFO, &argv); -  r =3D openvpn_execve_check (&argv, es,
> > M_WARN, "ERROR: Unable to set link layer address."); +  r =3D
> > openvpn_execve_check (&argv, NULL, M_WARN, "ERROR: Unable to set
> > link layer address.");
>
>
> I have just very quickly looked through this, and in most cases this
> seems fine.  openvpn_execve_check() most of the cases are calling a
> somewhat hard coded path to a binary.
>
> Except ... on Linux, configured with --enable-iprout2, OpenVPN can use
> the --iproute option which redefines at runtime which iproute2 binary
> it should use.  Removing the environment table in these cases may
> actually break some setups where the system can have a iproute2
> compatible wrapper which needs some of the environment variables.
>
> I have also seen the IRC discussion, where Gert argues that something
> else is not optimal when the environment variable space is exhausted.
>  I think a better fix would be to consider a way to filter out
> unneeded noise instead.

I'm afraid that's nearly impossible for me. These routes are IP addresses a=
nd ranges of blacklisted websites in Russia. They are already merged into b=
igger
subnets which shrank 25000+ IP addresses into =E2=89=8822000 IP ranges. I p=
robably can proxy non-blocked IP addresses to make the list even smaller, b=
ut it won't be
dramatically smaller, expect 15000+ addresses, which still breaks OS X for =
example.

Any ideas?

>
>
> > -----------------------------------------------------------------------=
-------



--------------45675C3CF9CAB2A9B13EC9CF
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Type=
">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    On 08/08/2016 11:34 AM, David Sommerseth wrote:<br>
    <blockquote type=3D"cite"><br>
      On 07/08/16 13:44, ValdikSS wrote:<br>
      &gt; It's possible to have so much routes that they won't fit into
      stack<br>
      &gt; and execve would fail with E2BIG (Argument list too long).<br>
      <br>
      &gt; This commit fixes this issue by not adding route information
      into<br>
      &gt; execve'd application env. --- src/openvpn/lladdr.c |=C2=A0 2 +- =
<br>
      &gt; src/openvpn/route.c=C2=A0 |=C2=A0 8 ++++---- src/openvpn/tun.c=
=C2=A0=C2=A0=C2=A0 | 12<br>
      &gt; ++++++------ 3 files changed, 11 insertions(+), 11
      deletions(-)<br>
      <br>
      &gt; diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
      index<br>
      &gt; 57f447b..d537379 100644 --- a/src/openvpn/lladdr.c +++<br>
      &gt; b/src/openvpn/lladdr.c @@ -58,7 +58,7 @@ int set_lladdr(const
      char<br>
      &gt; *ifname, const char *lladdr, #endif<br>
      <br>
      &gt; argv_msg (M_INFO, &amp;argv); -=C2=A0 r =3D openvpn_execve_check
      (&amp;argv, es,<br>
      &gt; M_WARN, "ERROR: Unable to set link layer address."); +=C2=A0 r =
=3D<br>
      &gt; openvpn_execve_check (&amp;argv, NULL, M_WARN, "ERROR: Unable
      to set<br>
      &gt; link layer address.");<br>
      <br>
      <br>
      I have just very quickly looked through this, and in most cases
      this<br>
      seems fine.=C2=A0 openvpn_execve_check() most of the cases are calling
      a<br>
      somewhat hard coded path to a binary.<br>
      <br>
      Except ... on Linux, configured with --enable-iprout2, OpenVPN can
      use<br>
      the --iproute option which redefines at runtime which iproute2
      binary<br>
      it should use.=C2=A0 Removing the environment table in these cases ma=
y<br>
      actually break some setups where the system can have a iproute2<br>
      compatible wrapper which needs some of the environment variables.<br>
      <br>
      I have also seen the IRC discussion, where Gert argues that
      something<br>
      else is not optimal when the environment variable space is
      exhausted.<br>
      =C2=A0I think a better fix would be to consider a way to filter out<b=
r>
      unneeded noise instead.<br>
    </blockquote>
    <br>
    I'm afraid that's nearly impossible for me. These routes are IP
    addresses and ranges of blacklisted websites in Russia. They are
    already merged into bigger subnets which shrank 25000+ IP addresses
    into =E2=89=8822000 IP ranges. I probably can proxy non-blocked IP addr=
esses
    to make the list even smaller, but it won't be dramatically smaller,
    expect 15000+ addresses, which still breaks OS X for example.<br>
    <br>
    Any ideas?<br>
    <br>
    <blockquote type=3D"cite"><br>
      <br>
    </blockquote>
    <span style=3D"white-space: pre;">&gt;
&gt; ----------------------------------------------------------------------=
--------</span><br>
    <br>
    <br>
  </body>
</html>

--------------45675C3CF9CAB2A9B13EC9CF--

--KimFpS1wlrRBXSUl6cToXVDI7eP6vtmH2--

--X8SgWlSnW8nuekQUq1DL7C28fiivGvoBo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIxBAEBCAAbBQJXsz9UFBxpYW1AdmFsZGlrc3Mub3JnLnJ1AAoJEFzXIC7viPdy
gTEQAKMs9iNTqqsOIc2H31lotdQAkE8FOnWzDnbzcjUaB9Ae6PhA24V/DeAZ3qG/
SnFpD08DfOojXQnBcSGAwIyXgZXFGYjUDeYJWFYZwvQgmmtfHzwLUsLlxJugGtwL
drlE9c5t2A+Mf3iPazcfDKRMl4sQuAYf0TbNe6pE0F5T/Ax3s5VaRQHVqJRaP1kT
ZebEBsVx5cB9WHDMUmeMND5nWJvHTEkEbdIQP3/eL5ETD+72uHDO7p5wOHEbRtTC
D0UH1s9rlAHSznR2pVk5JMkOv1jPKBUIkvcBgj+8LrPgBB88z49ej5Ro8wd0EBt1
DAlU/RHGm6yJHIuCW7A5RprdB50k2IrFlG22efzUhEaChgGtpecSmk6wyG/Jjfqs
8ddzCh1EVO8ykXrpqHn4os5JpbuweIIluBb8ekx5QwbQWKBAlADPSUrJ5dyutteR
W1rrQTdDMg3m6cNv7e38oi+lcRyHA6ghvxmomg1smJybFYN7uDAapW1Q5XZ/KjC2
FtC+2pvxZ8YU3sjik782wlEjpkU+JYlj/bweQRexiRa5kFNOxQq4EE70E3SNR7JQ
DH0+oBGXmiSSmSAK2beTwnTNDkUICNA/p63JlH3JtRGentiwCex7MPh9NKWggQ1V
R29XiIx85Hxb541pcnywzpgwblQ7wIWKu3zHGbCQ/RkzYxjx
=HzZp
-----END PGP SIGNATURE-----

--X8SgWlSnW8nuekQUq1DL7C28fiivGvoBo--

