MIME-Version: 1.0
In-Reply-To: <20151207154740.GD24952@...1296...>
References: <1449446507-16654-1-git-send-email-selva.nair@...277...>
	<20151207071641.GR24952@...1296...>
	<CAKuzo_iriPYgazMiq=FKwvYbvVE39t9X8zheKP4PqOVwbtjQ7Q@...278...>
	<20151207154740.GD24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 7 Dec 2015 13:57:20 -0500
Message-ID: <CAKuzo_hBQPwTeko0+DfkzdztyHJj=FaYOPqkbxzh8kGE3FnrpA@...278...>
Content-Type: multipart/alternative; boundary=001a1144424e6442cd0526536e5e
Subject: Re: [Openvpn-devel] [PATCH master] Add an autoconf macro to check
 WINAPI functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1144424e6442cd0526536e5e
Content-Type: text/plain; charset=UTF-8

Hi,

Sorry for the piece-meal replies.

On Mon, Dec 7, 2015 at 10:47 AM, Gert Doering <gert@...1296...> wrote:

> > AC_CHECK_DECL would detect inet_pton etc., because it only looks for the
> > declaration in a header. The macro I submitted works almost exactly like
> > AC_CHECK_DECL but defines HAVE_symbol instead of HAVE_DECL_symbol.
>
> Not good enough.  I want to be sure that the symbol is there, and that
> we actually have the right libraries (so maybe a double check "the symbol
> is there, but we cannot link, so fail" might be even better).


When pushed to a corner anything is possible...

It turns out that libws2_32 exports all the required function names without
any mangling (as if cdecl). Not sure this is mingw32 speciifc or not. Also
unlike I wrote inet_ntop is not redefined, its InetNtopA that is redfined.
Though Microsoft docs appears to indicate as if InetNtopA is the actual
name.

What it means is that a simple check without my much hated macro should be
possible. I'll post a version 2 tonight.

Thanks for the patience.

Selva

--001a1144424e6442cd0526536e5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">Sorry for the piece-meal replies.=
</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Dec=
 7, 2015 at 10:47 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:=
gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><span class=3D"">&gt; AC_CHECK_DECL would d=
etect inet_pton etc., because it only looks for the<br>
&gt; declaration in a header. The macro I submitted works almost exactly li=
ke<br>
&gt; AC_CHECK_DECL but defines HAVE_symbol instead of HAVE_DECL_symbol.<br>
<br>
</span>Not good enough.=C2=A0 I want to be sure that the symbol is there, a=
nd that<br>
we actually have the right libraries (so maybe a double check &quot;the sym=
bol<br>
is there, but we cannot link, so fail&quot; might be even better).</blockqu=
ote></div><br>When pushed to a corner anything is possible...</div><div cla=
ss=3D"gmail_extra"><br></div><div class=3D"gmail_extra">It turns out that l=
ibws2_32 exports all the required function names without any mangling (as i=
f cdecl). Not sure this is mingw32 speciifc or not. Also unlike I wrote ine=
t_ntop is not redefined, its InetNtopA that is redfined. Though Microsoft d=
ocs appears to indicate as if InetNtopA is the actual name.</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">What it means is that=
 a simple check without my much hated macro should be possible. I&#39;ll po=
st a version 2 tonight.</div><div class=3D"gmail_extra"><br></div><div clas=
s=3D"gmail_extra">Thanks for the patience.</div><div class=3D"gmail_extra">=
<br></div><div class=3D"gmail_extra">Selva</div></div>

--001a1144424e6442cd0526536e5e--

