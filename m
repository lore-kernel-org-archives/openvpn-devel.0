MIME-Version: 1.0
References: <CAAUX2SXb8MStU98ZEsswLkLDUM74zL6MapZC+=xc0_eYXwyEbw@...278...>
 <YkLkGj7WrC6ej0yR@...1296...>
In-Reply-To: <YkLkGj7WrC6ej0yR@...1296...>
From: Pete Nelson <petiepooo@...277...>
Date: Tue, 29 Mar 2022 18:33:14 +0000
Message-ID: <CAAYFXLk10kF11t=C-V0RQCJ_4ttm80BspZ2ErWoCwqMZQa3GMg@...278...>
Content-Type: multipart/alternative; boundary="00000000000016c53a05db5faa72"
Subject: Re: [Openvpn-devel] [ovpn-dco] can not delete tun interface
 automatically if option "user nobody" is used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Tony He <huangya90@...277...>, Antonio Quartulli <antonio@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000016c53a05db5faa72
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 29, 2022 at 10:50 AM Gert Doering <gert@...1296...> wrote:

> On Tue, Mar 29, 2022 at 06:21:37PM +0800, Tony He wrote:
> > 1. Add option "user nobody" to test ovpn-dco.
> > 2. Start openvpn, below is the log. Then we will see tun0 is still
> > there after openvpn exit. We must use the command "ip link del tunX"
> > to delete. This is not friendly to end user.
>
> Yes.  This is currently unsolved - if you tell openvpn to give up its
> privileges, it will give up its privileges, and then it lacks privileges
> to tear down the interface again.
>

Couldn't the down-root plugin be used?  It's biggest drawback for this is
that it's Linux-only, I suppose.

--00000000000016c53a05db5faa72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Mar 29, 2022 at 10:50 AM Gert Doe=
ring &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<=
br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Tue, Mar 29, 2022 at 06:21:37PM +0800, Tony He wrote:<br>
&gt; 1. Add option &quot;user nobody&quot; to test ovpn-dco.<br>
&gt; 2. Start openvpn, below is the log. Then we will see tun0 is still<br>
&gt; there after openvpn exit. We must use the command &quot;ip link del tu=
nX&quot;<br>
&gt; to delete. This is not friendly to end user.<br>
<br>
Yes.=C2=A0 This is currently unsolved - if you tell openvpn to give up its<=
br>
privileges, it will give up its privileges, and then it lacks privileges<br>
to tear down the interface again.<br></blockquote><div><br></div><div>Could=
n&#39;t the down-root plugin be used?=C2=A0 It&#39;s biggest drawback for t=
his is that it&#39;s Linux-only, I suppose.<br></div></div></div>

--00000000000016c53a05db5faa72--

