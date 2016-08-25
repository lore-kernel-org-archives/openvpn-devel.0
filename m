MIME-Version: 1.0
In-Reply-To: <8e9eb1dd-2505-7414-4828-6d6b6d1e25f0@...2080...>
References: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>
	<1472133483.61594.587.camel@...1866...>
	<8e9eb1dd-2505-7414-4828-6d6b6d1e25f0@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 25 Aug 2016 10:32:16 -0400
Message-ID: <CAKuzo_j0XwQ7OR8E-wGcTQDwEjdRbTZZy84wK68qgZLS30sT7g@...278...>
Content-Type: multipart/alternative; boundary=001a114eafecee298f053ae64435
Subject: Re: [Openvpn-devel] [RFC] - Enable 2FA to be used with
	renegotiations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114eafecee298f053ae64435
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 25, 2016 at 10:15 AM, David Sommerseth <
openvpn@...2080...> wrote:

> On 25/08/16 15:58, David Woodhouse wrote:
> > On Thu, 2016-08-25 at 15:45 +0200, David Sommerseth wrote:
> >>
> >>
> >> I've been working a bit on a new patch-set which enables
> >> third-party user/password authentication mechanisms using two
> >> factor authentications [2FA] (such as OTP) and not needing to
> >> disable the renegotiation features of OpenVPN.
> >
> > Hm, you handle the server side of OTP through PAM alone?
>
> This change does not change the initial authentication at all.  You
> still need an authentication plug-in or --auth-user-pass-verify
> script.  But once this first authentication passes successfully, the
> OpenVPN server takes over the coming authentications required due to
> re-negotiations.


Why not let the auth-user-pass-verify script do this verification bypass?
The server knows whether its an initial CONNECT or REAUTH and can pass that
info to the verify script. Then the script can bypass verification if
appropriate. Currently management-client-auth is already capable of doing
this as "REAUTH" versus "CONNECT" info is passed to it. Adding that to the
env and passing to scripts should be easy.

Selva

--001a114eafecee298f053ae64435
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Aug 25, 2016 at 10:15 AM, David Sommerseth <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 2=
5/08/16 15:58, David Woodhouse wrote:<br>
&gt; On Thu, 2016-08-25 at 15:45 +0200, David Sommerseth wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ve been working a bit on a new patch-set which enables<br>
&gt;&gt; third-party user/password authentication mechanisms using two<br>
&gt;&gt; factor authentications [2FA] (such as OTP) and not needing to<br>
&gt;&gt; disable the renegotiation features of OpenVPN.<br>
&gt;<br>
&gt; Hm, you handle the server side of OTP through PAM alone?<br>
<br>
</span>This change does not change the initial authentication at all.=C2=A0=
 You<br>
still need an authentication plug-in or --auth-user-pass-verify<br>
script.=C2=A0 But once this first authentication passes successfully, the<b=
r>
OpenVPN server takes over the coming authentications required due to<br>
re-negotiations.</blockquote></div><br>Why not let the auth-user-pass-verif=
y script do this verification bypass? The server knows whether its an initi=
al CONNECT or REAUTH and can pass that info to the verify script. Then the =
script can bypass verification if appropriate. Currently management-client-=
auth is already capable of doing this as &quot;REAUTH&quot; versus &quot;CO=
NNECT&quot; info is passed to it. Adding that to the env and passing to scr=
ipts should be easy.</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">Selva</div></div>

--001a114eafecee298f053ae64435--

