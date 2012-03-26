MIME-Version: 1.0
In-Reply-To: <4F703565.3070008@...1114...>
References: <4F6D06C5.3030408@...1114...>
	<1332575918-3384-4-git-send-email-alon.barlev@...277...>
	<4F703565.3070008@...1114...>
Date: Mon, 26 Mar 2012 12:25:25 +0200
Message-ID: <CAOazyz2Zt98TKwfr1zyALc-6fgOeDEgCW4Br4rOM0PT290_kFw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 3/6] tree: ChangeLog: add ident attribute
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
Cc: Openvpn-devel@lists.sourceforge.net

On Mon, Mar 26, 2012 at 11:22 AM, David Sommerseth
<openvpn.list@...1114...> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 24/03/12 08:58, Alon Bar-Lev wrote:
> > --- .gitattributes | =C2=A0 =C2=A01 + ChangeLog =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 =C2=A02 ++ 2 files changed,
> > 3 insertions(+), 0 deletions(-) create mode 100644 .gitattributes
> >
> > diff --git a/.gitattributes b/.gitattributes new file mode 100644
> > index 0000000..9cf9e1f --- /dev/null +++ b/.gitattributes @@ -0,0 +1
> > @@ +ChangeLog ident diff --git a/ChangeLog b/ChangeLog index
> > d498344..d7cc77c 100644 --- a/ChangeLog +++ b/ChangeLog @@ -1,6 +1,8
> > @@ OpenVPN Change Log Copyright (C) 2002-2011 OpenVPN Technologies,
> > Inc. <sales@...515...>
> >
> > +$Id$ +
>
> What is the purpose of this change?

Oh...
I remembered that this was in tree long ago[1], thought that it was
dropped out when moving to git not intentionally.

If otherwise, ignore this patch.

It is nice to see the revision of the changelog as most probably it is
the last revision before release. So if one forget to tag or something
the data is available.

Alon.

[1] http://svn.openvpn.net/projects/openvpn/branches/2.0/openvpn/ChangeLog

