MIME-Version: 1.0
Date: Mon, 1 Mar 2010 07:22:39 +0200
Message-ID: <9e0cf0bf1002282122m606ffacbw2ecf753037c338de@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [Feedback needed] Fix cross compile support
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

Yes, it is better than current. Should use --host=3D and not --target=3D
for cross compile.

1. I would not touch host_alias it is irrelevant and may lead to
problems. Use only host variable in autoconf.

2. The case in autoconf should be '*-*-os*)' and not '*os*)'

3. I don't think it is so important to change the TARGET_XXX into
HOST_XXX through out the source.

Alon.

On Sun, Feb 28, 2010 at 11:25 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
> I'm reviewing this patch in the patch tracker, and cannot make up my
> mind if this is correct or not. =C2=A0Can someone please advise if this is
> something we should include or not?
>
> <https://sourceforge.net/tracker/?func=3Ddetail&aid=3D2491190&group_id=3D=
48978&atid=3D454721>
>
>
> kind regards,
>
> David Sommerseth
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkuK3zYACgkQDC186MBRfrr9qQCghRPXQ9qOkVn1OYJXdXxAqHgy
> zEoAnjEUPrIjBXS3+hh1DuiY1p2HbVsk
> =3Dri8p
> -----END PGP SIGNATURE-----
>
> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

