MIME-Version: 1.0
References: <1573760407-20662-1-git-send-email-selva.nair@...277...>
 <108f5ba4-240b-5496-f37b-51ff2a6fb2fe@...2080...>
In-Reply-To: <108f5ba4-240b-5496-f37b-51ff2a6fb2fe@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 14 Nov 2019 16:58:17 -0500
Message-ID: <CAKuzo_he9FoT-iC-FZAW7qQH2vepY+XmOfsiL6uSH=7hW8ZvVQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000030aa33059755954d"
Subject: Re: [Openvpn-devel] [PATCH] Fix ACL_CHECK_ADD_COMPILE_FLAGS to work
 with clang
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000030aa33059755954d
Content-Type: text/plain; charset="UTF-8"

Hi David

Thanks for the comments

My idea was just to add -Werror right in the line above, and not extend the
> ACL_CHECK_ADD_COMPILE_FLAGS macro with another argument.
>

I'm fine with that approach as well. Let me know if you want a v2.


> I think you said it pretty well in your mail:
>
> > Darn compilers and darn -Werror
>
>
> So your change does improve Clang ... I dunno what we will do with GCC.
>

It doesn't affect gcc as gcc does error (or ignore -- see below)
unsupported options with or without -Werror. So I think we are okay. travis
build on my fork confirms that:
https://travis-ci.org/selvanair/openvpn/builds/612019849

However, gcc does have quirky behaviour when it comes to options like
-Wno-xx-yy. It just accepts them silently[*] with or without -Werror. That
works fine for us, but it does generate an error about that unsupported
option if any other error is encountered during the build.  As other errors
are anyway a show-stopper, I think we can live with that.

Selva

[*] I think their reasoning is that -Wno-xx-yy can be thus used to suppress
warnings added to newer versions without breaking builds with older ones.
But clang doesn't share that view.

--00000000000030aa33059755954d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi David<br></div><div class=3D"gmail_quo=
te"><br></div><div class=3D"gmail_quote">Thanks for the comments</div><div =
class=3D"gmail_quote"><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div class=3D"gmail_quote">My idea was just to add -Werror right in =
the line above, and not extend the<br>
ACL_CHECK_ADD_COMPILE_FLAGS macro with another argument.</div></blockquote>=
<div><br></div><div>I&#39;m fine with that approach as well. Let me know if=
 you want a v2.<br></div><div> <br></div><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
I think you said it pretty well in your mail:<br>
<br>
&gt; Darn compilers and darn -Werror<br>
<br>
<br>
So your change does improve Clang ... I dunno what we will do with GCC.<br>=
</blockquote><div><br></div><div>It doesn&#39;t affect gcc as gcc does erro=
r (or ignore -- see below) unsupported options with or without -Werror. So =
I think we are okay. travis build on my fork confirms that:</div><div><a hr=
ef=3D"https://travis-ci.org/selvanair/openvpn/builds/612019849" rel=3D"nore=
ferrer" target=3D"_blank">https://travis-ci.org/selvanair/openvpn/builds/61=
2019849</a></div><div><br></div><div>However, gcc does have quirky behaviou=
r when it comes to options like -Wno-xx-yy. It just accepts them silently[*=
] with or without -Werror. That works fine for us, but it does generate an =
error about that unsupported option if any other error is encountered durin=
g the build.=C2=A0 As other errors are anyway a show-stopper, I think we ca=
n live with that.</div><div><br></div><div>Selva</div><div><br></div><div>[=
*] I think their reasoning is that -Wno-xx-yy can be thus used to suppress =
warnings added to newer versions without breaking builds with older ones. B=
ut clang doesn&#39;t share that view.<br></div></div></div>

--00000000000030aa33059755954d--

