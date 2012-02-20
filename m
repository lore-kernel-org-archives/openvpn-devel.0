MIME-Version: 1.0
In-Reply-To: <20120220213246.GV7024@...1296...>
References: <CAOazyz08kLGKyq-Wcd1KTQ9akdQCAYPP9b1aMVne-b9TArMKDQ@...278...>
	<1329749121-24501-1-git-send-email-alon.barlev@...277...>
	<4F426F81.6040201@...1114...>
	<CAOazyz1DhzxPf3GS1dqhYKXSkL5NeSDy03z340VYibKWBKxPRQ@...278...>
	<CAOazyz1uZY2Entpuq4tn0DdBbQEZk32iugtmbttOkCrdbjK7Jw@...278...>
	<20120220203913.GU7024@...1296...>
	<CAOazyz2w6mYjDAsRrgDawrEpb0QegHZVYnqp04TFZC5DgDyRTg@...278...>
	<20120220213246.GV7024@...1296...>
Date: Mon, 20 Feb 2012 23:37:22 +0200
Message-ID: <CAOazyz2Z07RviXeqosOrSzq3+rU0TrFqZ001c3j60nELsrVJPw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] windows: do not use X_OK as it is
	unsupported
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

I think that wrapping the whole access is one step farther...
The other two are better.
But it is still better than redefining X_OK... :)

Alon.

On Mon, Feb 20, 2012 at 11:32 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Mon, Feb 20, 2012 at 10:44:31PM +0200, Alon Bar-Lev wrote:
>> It still touches the same places...
>>
>> The difference is the usage:
>> ---
>> R_OK|PLATFORM_X_OK
>> ---
>> or:
>> ---
>> PLATFORM_MODE_MASK(R_OK | X_OK)
>> ---
>
> Nah, that's not the way it should be.
>
> Given that we currently use X_OK only in options.c, and have MANY lines
> of the form
>
> =C2=A0 =C2=A0errs |=3D check_file_access (CHKACC_FILE, options->crl_file,=
 R_OK|X_OK,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "--crl-verify directory");
>
> and only a single place where it will actually call access()
> (or _access()), anything that makes all these lines harder to read
> is making the code harder to read.
>
> This code doesn't want or need to know anything about system dependencies,
> that belongs inside check_file_access() - and there you have only a few
> access() calls that need to do PLATFORM_MODE_MASK().
>
> Or even better, do it in the openvpn_access() wrapper, in the #ifdef WIN32
> code block. =C2=A0That is the place where the WIN32 pain is, and nobody e=
lse
> needs to bother.
>
> int
> openvpn_access (const char *path, int mode)
> {
> #ifdef WIN32
> =C2=A0struct gc_arena gc =3D gc_new ();
> =C2=A0int ret =3D _waccess (wide_string (path, &gc), (mode & ~X_OK) );
> =C2=A0gc_free (&gc);
> =C2=A0return ret;
> #else
> =C2=A0return access (path, mode);
> #endif
> }
>
> gert
>
>
> --
> USENET is *not* the non-clickable part of WWW!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //www.muc.de/~gert/
> Gert Doering - Munich, Germany =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gert@...1296...
> fax: +49-89-35655025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gert@...1297...

