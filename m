MIME-Version: 1.0
References: <20200609175503.GU1431@...1296...>
In-Reply-To: <20200609175503.GU1431@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Jun 2020 14:22:01 -0400
Message-ID: <CAKuzo_hOf8oLo7vD9OYDvVkSzAd7R5iKhcayDX4W5Q9ExHcVYQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000041a74e05a7e728c2"
Subject: Re: [Openvpn-devel] async plugin-auth-pam
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000041a74e05a7e728c2
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 9, 2020 at 1:55 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> I ran into a problem at a customer installation recently, where
> plugin-auth-pam was blocking for some extended time (~30 seconds?)
> due to pam_radius not receiving answers due to problems in the backend.
>
> Now, maybe I should use radiusplugin in the first place, but since
> the pam_radius setup on this machine is shared between sshd and OpenVPN,
> I actually *like* using plugin-auth-pam -> pam_radius ("test one service,
> know that radius very likely works for both").
>
> That said, I'm considering modifying the plugin-auth-pam plugin to
> add async authentication - which is supposedly not so hard
> ("sample-plugins/defer/simple.c").
>
> Has one of you already done this, and just forgot to send in patches? :-)
>
> Any particular caveats?
>

I do not have a patch, but had briefly considered this while looking into
handling "dynamic challenge" through the plugin.

Just deferring an authentication is easy but the server will still stall if
another client comes in during that deferred period as pam auth is handled
by a single process. The plugin forks leaving a child running as root, and
talks to it via a scoket. The latter does the pam authentication. As pam
runs within that process, it will still be waiting for the authentication
to complete in a blocking call to pam_authenticate(). I felt it will take
considerable effort to make it handle pam auth asynchronously.

Things may be easier if modules that take long to verify the credentials,
return something like PAM_INCOMPLETE, so that it can be called back later.
But that is beyond our control, and I'm not familiar with async support
within PAM or in PAM modules.

Selva

--00000000000041a74e05a7e728c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 9, 2020 at 1:55 PM Gert D=
oering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
I ran into a problem at a customer installation recently, where <br>
plugin-auth-pam was blocking for some extended time (~30 seconds?)<br>
due to pam_radius not receiving answers due to problems in the backend.<br>
<br>
Now, maybe I should use radiusplugin in the first place, but since <br>
the pam_radius setup on this machine is shared between sshd and OpenVPN,<br>
I actually *like* using plugin-auth-pam -&gt; pam_radius (&quot;test one se=
rvice,<br>
know that radius very likely works for both&quot;).<br>
<br>
That said, I&#39;m considering modifying the plugin-auth-pam plugin to<br>
add async authentication - which is supposedly not so hard <br>
(&quot;sample-plugins/defer/simple.c&quot;).<br>
<br>
Has one of you already done this, and just forgot to send in patches? :-)<b=
r>
<br>
Any particular caveats?<br></blockquote><div><br></div><div>I do not have a=
 patch, but had briefly considered this while looking into handling &quot;d=
ynamic challenge&quot; through the plugin.<br><br></div><div>Just deferring=
 an authentication is easy but the server will still stall if another clien=
t comes in during that deferred period as pam auth is handled by a single p=
rocess. The plugin forks leaving a child running as root, and talks to it v=
ia a scoket. The latter does the pam authentication. As pam runs within tha=
t process, it will still=C2=A0be waiting for the authentication to complete=
 in a blocking call to pam_authenticate(). I felt it will take considerable=
 effort to make it handle pam auth asynchronously.</div><div><br></div><div=
>Things may be easier if modules that take long to verify the credentials, =
return something like PAM_INCOMPLETE, so that it can be called back later. =
But that is beyond our control, and I&#39;m not familiar with async support=
 within PAM or in PAM modules.</div><div><br></div><div>Selva</div></div></=
div>

--00000000000041a74e05a7e728c2--

