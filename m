MIME-Version: 1.0
In-Reply-To: <3fda1204-41dc-39a2-4fe6-cad66cd86c88@...2080...>
References: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
	<CAFHpkQEQUM7U40aYeKQy=rA7tiRcGxUrFxusOrLHhq-MfPUgrA@...278...>
	<3fda1204-41dc-39a2-4fe6-cad66cd86c88@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 31 Aug 2016 17:25:40 -0400
Message-ID: <CAKuzo_iNNRCqfn=+9nv_n25mUF7akOW_6cec_JhU6dMuaV4nqQ@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0438f8688585053b64bed7
Subject: Re: [Openvpn-devel] Modernising the management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0438f8688585053b64bed7
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed, Aug 31, 2016 at 4:11 PM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

> > It is not being planned to remove the management interface.  If
> > D-Bus works well for everyone on all platforms, then we can discuss
> > what to do next.  But as of now, I have no plans to remove this
> > part of the code.
>

That's all what I wanted to hear -- as long as the management interface
(MI) is not going anywhere, no need to panic, right? I like the simple
design of the current MI that makes it so easy to debug over command line,
support on virtually any platform without external libraries etc. Even with
D-Bus one has to still send messages specific to the application and the UI
developer has to learn a few new keywords. Not very different from the
current state of affairs unless we have a use case that is not easy to
support over the current MI. I have never used D-Bus so no idea of the
status of Windows support -- I believe the reference implementation as a
windows port, not sure how well maintained it is.

One limitation of the current setup is lack of a security layer which makes
passing passwords, keys etc not very safe. I suppose D-Bus has security
features?

Selva

--94eb2c0438f8688585053b64bed7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Wed, Aug 31, 2016 at 4:11 PM, David =
<span class=3D"" id=3D":7dl.1" tabindex=3D"-1">Sommerseth</span> <span dir=
=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank"><span =
class=3D"" id=3D":7dl.2" tabindex=3D"-1">openvpn</span>@sf.lists.<wbr><span=
 class=3D"" id=3D":7dl.3" tabindex=3D"-1">topphemmelig</span>.net</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div>&gt; It is not being pl=
anned to remove the management interface.=C2=A0 If<br>
&gt; D-Bus works well for everyone on all platforms, then we can discuss<br>
&gt; what to do next.=C2=A0 But as of now, I have no plans to remove this<b=
r>
&gt; part of the code.</div></blockquote></div><div class=3D"gmail_extra"><=
br></div>That&#39;s all what I wanted to hear -- as long as the management =
interface (MI) is not going anywhere, no need to panic, right? I like the s=
imple design of the current MI that makes it so easy to debug over command =
line, support on virtually any platform without external libraries etc. Eve=
n with D-Bus one has to still send messages specific to the application and=
 the <span class=3D"" id=3D":7dl.4" tabindex=3D"-1">UI</span> developer has=
 to learn a few new keywords. Not very different from the current state of =
affairs unless we have a use case that is not easy to support over the curr=
ent MI. I have never used D-Bus so no idea of the status of Windows support=
 -- I believe the reference implementation as a windows port, not sure how =
well maintained it is.</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">One limitation of the current setup is lack of a security =
layer which makes passing passwords, keys etc not very safe. I suppose D-Bu=
s has security features?</div><div class=3D"gmail_extra"><br></div><div cla=
ss=3D"gmail_extra"><span class=3D"" id=3D":7dl.5" tabindex=3D"-1">Selva</sp=
an></div></div>

--94eb2c0438f8688585053b64bed7--

