MIME-Version: 1.0
In-Reply-To: <201705131817.v4DIHG9I006125@...2054...>
References: <1494552754-30060-1-git-send-email-selva.nair@...277...>
	<201705131817.v4DIHG9I006125@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 13 May 2017 19:52:20 -0400
Message-ID: <CAKuzo_gJp5Bes4t=O2HxsLHrXV=oqS+=Hwm9iku9NG6Ro4PaJg@...278...>
Content-Type: multipart/alternative; boundary="f403045c8bca7db812054f70847a"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Pass correct buffer size to
	GetModuleFileNameW()
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

--f403045c8bca7db812054f70847a
Content-Type: text/plain; charset="UTF-8"

On Sat, May 13, 2017 at 2:17 PM, Gert Doering <gert@...1296...> wrote:

> ACK, thanks.  (No tests run whatsoever, but we've had a discussion about
> that on the security@ lists, and there was agreement that _countof is
> the thing to use - just nobody did it before, so thanks again :-) ).
>
> Your patch has been applied to the master and release/2.4 branch.
>
> Release/2.3 has "MAX_PATH" instead of sizeof or _countof, which is
> actually correct (but in contrast, it has no error checking for
> GetModuleFileNameW()...)
>

Oh, I missed that. Note to self: we should add error checking there. If the
buffer is too small we will get a truncated but null terminated name, so
that's not too bad. But if the call fails the buffer may contain random
bytes.

Selva

--f403045c8bca7db812054f70847a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, May 13, 2017 at 2:17 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div id=3D":2s8" class=3D"a3s aX=
jCH m15c03076d0261002">ACK, thanks.=C2=A0 (No tests run whatsoever, but we&=
#39;ve had a discussion about<br>
that on the security@ lists, and there was agreement that _countof is<br>
the thing to use - just nobody did it before, so thanks again :-) ).<br>
<br>
Your patch has been applied to the master and release/2.4 branch.<br>
<br>
Release/2.3 has &quot;MAX_PATH&quot; instead of sizeof or _countof, which i=
s<br>
actually correct (but in contrast, it has no error checking for<br>
GetModuleFileNameW()...)</div></blockquote></div><br>Oh, I missed that. Not=
e to self: we should add error checking there. If the buffer is too small w=
e will get a truncated but null terminated name, so that&#39;s not too bad.=
 But if the call fails the buffer may contain random bytes.</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div></div>

--f403045c8bca7db812054f70847a--

