MIME-Version: 1.0
In-Reply-To: <20170612181403.GK97029@...1296...>
References: <1494008642-7239-1-git-send-email-selva.nair@...277...>
	<1494008642-7239-2-git-send-email-selva.nair@...277...>
	<20170612181403.GK97029@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 12 Jun 2017 14:28:16 -0400
Message-ID: <CAKuzo_iD6H_O0AvCvheLc9jskVCZeGV5FaWQjJbmUQZB2w9JaQ@...278...>
Content-Type: multipart/alternative; boundary="001a113d2f52c8741e0551c77c5f"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Parse static challenge response in
 auth-pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113d2f52c8741e0551c77c5f
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 12, 2017 at 2:14 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> wading through my heap of mails that did not get proper attention...
>
> On Fri, May 05, 2017 at 02:24:02PM -0400, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > If static challenge is in use, the password passed to the plugin by
> openvpn
> > is of the form "SCRV1:base64-pass:base64-response". Parse this string to
> > separate it into password and response and use them to respond to queries
> > in the pam conversation function.
> >
> > On the plugin parameters line the substitution keyword for the static
> > challenge response is "OTP". For example, for pam config named "test"
> that
> > prompts for "user", "password" and "pin", use
> >
> > plugin openvpn-auth-pam.so "test user USERNAME password PASSWORD pin OTP"
>
> What is the status of this one?  Does it need updating after 1/2 got
> changed to v2 and v3 are these independent enough that 2/2 is standalone?
>
> From a cursory glance, it calls secure_memzero() which is now, I think,
> plugin_secure_memzero() - right?
>
>
> I also seem to remember discussions between you and David regarding
> base64 function exporting - what's the state on this?
>


I have a version 2 that uses exported base64 but waiting on the following
patch to get an NAK or ACK to finalize it.

   https://www.mail-archive.com/openvpn-devel@...1357...
rge.net/msg14655.html

That would also help David's base64 export patch revised, reviewed and
merged. For background, see the thread

https://www.mail-archive.com/openvpn-devel@...1199...
sourceforge.net/msg14577.html

Selva

--001a113d2f52c8741e0551c77c5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Jun 12, 2017 at 2:14 PM, Gert Doering <span dir=3D"ltr">&lt;<a =
href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-le=
ft-style:solid;padding-left:1ex">Hi,<br>
<br>
wading through my heap of mails that did not get proper attention...<br>
<span class=3D"m_5899158160508331057gmail-m_-2333955419087183461gmail-"><br>
On Fri, May 05, 2017 at 02:24:02PM -0400, <a href=3D"mailto:selva.nair@...1665...=
77..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt;<br>
&gt; If static challenge is in use, the password passed to the plugin by op=
envpn<br>
&gt; is of the form &quot;SCRV1:base64-pass:base64-resp<wbr>onse&quot;. Par=
se this string to<br>
&gt; separate it into password and response and use them to respond to quer=
ies<br>
&gt; in the pam conversation function.<br>
&gt;<br>
&gt; On the plugin parameters line the substitution keyword for the static<=
br>
&gt; challenge response is &quot;OTP&quot;. For example, for pam config nam=
ed &quot;test&quot; that<br>
&gt; prompts for &quot;user&quot;, &quot;password&quot; and &quot;pin&quot;=
, use<br>
&gt;<br>
&gt; plugin openvpn-auth-pam.so &quot;test user USERNAME password PASSWORD =
pin OTP&quot;<br>
<br>
</span>What is the status of this one?=C2=A0 Does it need updating after 1/=
2 got<br>
changed to v2 and v3 are these independent enough that 2/2 is standalone?<b=
r>
<br>
From a cursory glance, it calls secure_memzero() which is now, I think,<br>
plugin_secure_memzero() - right?<br>
<br>
<br>
I also seem to remember discussions between you and David regarding<br>
base64 function exporting - what&#39;s the state on this?<br></blockquote><=
div><br></div><div><br></div><div>I have a version 2 that uses exported bas=
e64 but waiting on the following patch to get an NAK or ACK to finalize it.=
</div><div><br></div><div>=C2=A0=C2=A0=C2=A0<a href=3D"https://www.mail-arc=
hive.com/openvpn-devel@lists.sourceforge.net/msg14655.html" target=3D"_blan=
k">https://www.mail-archive.co<wbr>m/openvpn-devel@...1357...<wbr>rge.net/m=
sg14655.html</a></div><div><br></div><div>That would also help David&#39;s =
base64 export patch revised, reviewed and merged. For background, see the t=
hread</div><div><br></div><div><a href=3D"https://www.mail-archive.com/open=
vpn-devel@lists.sourceforge.net/msg14577.html" target=3D"_blank">https://ww=
w.mail-archive.com/<wbr>openvpn-devel@...1199...<wbr>sourceforge.net/msg145=
77.html</a><br></div><div><br></div><div>Selva</div></div></div></div>

--001a113d2f52c8741e0551c77c5f--

