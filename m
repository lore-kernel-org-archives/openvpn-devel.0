MIME-Version: 1.0
In-Reply-To: <57A72DA2.1090003@...277...>
References: <57A3C76A.1020809@...277...>
	<CAKuzo_h0vMR4jv=iAgT2Vr2kq-nJRDs0Pq=3JC7eydQ-m1Ucpw@...278...>
	<57A72DA2.1090003@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 7 Aug 2016 17:55:51 +0500
Message-ID: <CAFHpkQHbufM9=+_SwgesYzV=vPR3_dT_EMxakkGdOk2HmjvTKA@...278...>
Content-Type: multipart/alternative; boundary=047d7bd91a66cce71905397ad1b3
Subject: Re: [Openvpn-devel] Win10 Tun Server +Standard W10 User +OVPN
 Interactive Service +OVPN GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Debbie Tent <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--047d7bd91a66cce71905397ad1b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I also noticed, that "openvpn administrators" membership is required.

Should we modify installer to make it adf current user to that group?

7 =D0=B0=D0=B2=D0=B3. 2016 =D0=B3. 17:48 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=
=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "debbie10t" <debbie10t@...277...> =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

>
>
> On 05/08/16 03:04, Selva Nair wrote:
> > On Thu, Aug 4, 2016 at 6:53 PM, debbie10t <debbie10t@...277...> wrote:
> >
> >> Hi
> >>
> >> So windows 10 as a Server.
> >>
> >>
> >> If you have any specific tests please send me details.
> >>
> > Tasks needing admin access happens early on when the server starts so
> this
> > looks good especially since you tested ipv6 as well.
> >
> > One thing to try:
> > With the server running, edit the config to change the tunnel network (=
ip
> > and pool) and issue a SIGHUP to re-read the config (reconnect from the
> GUI
> > status window will do this). The old routes should get torn down (log
> will
> > show route deletion via service succeeded) the ip should change to the
> new
> > one and new routes get added etc.
> This worked no problem.
>
> >
> > Although not related to the interactive service, you could also test
> > running the server on a port < 1024. This being windows I suppose bindi=
ng
> > to "privileged" ports doesn't require admin rights.
> >
> >
> Have not tried this yet.
>
>
> However, during my testing the following happened:
>
> I installed the first server in /program files/openvpn/config and running
> as standard-user with openvpn GUI & IService, this worked no problem.
>
> Then I tried with the config file in /users/user/openvpn/config and runni=
ng
> as standard-user:user with gui & IService, Starting the server, I was
> prompted
> to add my user to the openvpn administrators group.
>
> I am not sure if this is intended behaviour, that the group membership is
> *only* prompted when using user/openvpn/config/file.ovpn ?
>
> --
>
>
> ------------------------------------------------------------
> ------------------
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--047d7bd91a66cce71905397ad1b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I also noticed, that &quot;openvpn administrators&quot; memb=
ership is required.<br></p>
<p dir=3D"ltr">Should we modify installer to make it adf current user to th=
at group?</p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">7 =D0=B0=D0=B2=D0=
=B3. 2016 =D0=B3. 17:48 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D0=B5=D0=BB=D1=8C &quot;debbie10t&quot; &lt;<a href=3D"mailto:debbie10t=
@...277...">debbie10t@...277...</a>&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BB:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 05/08/16 03:04, Selva Nair wrote:<br>
&gt; On Thu, Aug 4, 2016 at 6:53 PM, debbie10t &lt;<a href=3D"mailto:debbie=
10t@...277...">debbie10t@...277...</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; Hi<br>
&gt;&gt;<br>
&gt;&gt; So windows 10 as a Server.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; If you have any specific tests please send me details.<br>
&gt;&gt;<br>
&gt; Tasks needing admin access happens early on when the server starts so =
this<br>
&gt; looks good especially since you tested ipv6 as well.<br>
&gt;<br>
&gt; One thing to try:<br>
&gt; With the server running, edit the config to change the tunnel network =
(ip<br>
&gt; and pool) and issue a SIGHUP to re-read the config (reconnect from the=
 GUI<br>
&gt; status window will do this). The old routes should get torn down (log =
will<br>
&gt; show route deletion via service succeeded) the ip should change to the=
 new<br>
&gt; one and new routes get added etc.<br>
This worked no problem.<br>
<br>
&gt;<br>
&gt; Although not related to the interactive service, you could also test<b=
r>
&gt; running the server on a port &lt; 1024. This being windows I suppose b=
inding<br>
&gt; to &quot;privileged&quot; ports doesn&#39;t require admin rights.<br>
&gt;<br>
&gt;<br>
Have not tried this yet.<br>
<br>
<br>
However, during my testing the following happened:<br>
<br>
I installed the first server in /program files/openvpn/config and running<b=
r>
as standard-user with openvpn GUI &amp; IService, this worked no problem.<b=
r>
<br>
Then I tried with the config file in /users/user/openvpn/config and running=
<br>
as standard-user:user with gui &amp; IService, Starting the server, I was<b=
r>
prompted<br>
to add my user to the openvpn administrators group.<br>
<br>
I am not sure if this is intended behaviour, that the group membership is<b=
r>
*only* prompted when using user/openvpn/config/file.ovpn ?<br>
<br>
--<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div></div>

--047d7bd91a66cce71905397ad1b3--

