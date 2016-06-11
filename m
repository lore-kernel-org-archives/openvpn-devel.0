MIME-Version: 1.0
In-Reply-To: <20160611202621.GU62247@...1296...>
References: <0d1ed9a2-71f4-f791-3633-9937b3764de1@...1227...>
	<1465656195-12722-1-git-send-email-arne@...1227...>
	<20160611181434.GT62247@...1296...>
	<CAKuzo_gJLLjMWM7RRP=QzHBAEA6==f1BhEEa8gjL2W_FcGN-5A@...278...>
	<20160611202621.GU62247@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 11 Jun 2016 16:47:38 -0400
Message-ID: <CAKuzo_iFqH_uoAPKCL3GtHv9SE9P0Hn6BYyjmc_g9t3VL-C2ZQ@...278...>
Content-Type: multipart/alternative; boundary=001a1147f47e30c4c0053506c54b
Subject: Re: [Openvpn-devel] [[PATCH v3]] Remove http-proxy-timeout,
 socks timeout and set default of server-poll-timeout to 120s
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

--001a1147f47e30c4c0053506c54b
Content-Type: text/plain; charset=UTF-8

On Sat, Jun 11, 2016 at 4:26 PM, Gert Doering <gert@...1296...> wrote:

> On Sat, Jun 11, 2016 at 02:47:47PM -0400, Selva Nair wrote:
> > Isn't this controlled by the http-proxy-retry option which is off by
> > default? Set that in the config and SIGUSR1 restart should happen, I
> > think...
>
> Right you are, and ditto for --socks-proxy-retry.
>
> Sat Jun 11 22:23:50 2016 Attempting to establish TCP connection with
> [AF_INET]195.30.4.1:23 [nonblock]
> Sat Jun 11 22:23:51 2016 TCP connection established with [AF_INET]
> 195.30.4.1:23
> Sat Jun 11 22:23:51 2016 Send to HTTP proxy: 'CONNECT 10.0.0.1:51196
> HTTP/1.0'
> Sat Jun 11 22:23:51 2016 Send to HTTP proxy: 'Host: 10.0.0.1'
> Sat Jun 11 22:24:10 2016 recv_line: TCP port read timeout expired:
> Operation now in progress (errno=115)
> Sat Jun 11 22:24:10 2016 SIGUSR1[soft,init_instance] received, process
> restarting
> Sat Jun 11 22:24:10 2016 Restart pause, 5 second(s)
> [..]
> Sat Jun 11 22:24:15 2016 Attempting to establish TCP connection with
> [AF_INET]195.30.4.1:23 [nonblock]
>
>
> (Side note: you win the "who knows more obscure/rarely used OpenVPN
> options"
> contest today :-) )
>

I respectfully decline to accept..:-)

I've been scruitinizing every SIGsomething in the code as a part of my
foray into "Signals in OpenVPN", saw this option only the other day for the
first time..


>
> I do wonder how useful these settings are, and why they are not default...
> they predate my OpenVPN involvement by many years.


No clue..

Selva

--001a1147f47e30c4c0053506c54b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Jun 11, 2016 at 4:26 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span>On Sat, Jun 11, 2016 at 02=
:47:47PM -0400, Selva Nair wrote:<br>
&gt; Isn&#39;t this controlled by the http-proxy-retry option which is off =
by<br>
&gt; default? Set that in the config and SIGUSR1 restart should happen, I<b=
r>
&gt; think...<br>
<br>
</span>Right you are, and ditto for --socks-proxy-retry.<br>
<br>
<span><span>Sat Jun 11 22:23:50 2016</span></span> Attempting to establish =
TCP connection with [AF_INET]<a href=3D"http://195.30.4.1:23" rel=3D"norefe=
rrer" target=3D"_blank">195.30.4.1:23</a> [nonblock]<br>
<span><span>Sat Jun 11 22:23:51 2016</span></span> TCP connection establish=
ed with [AF_INET]<a href=3D"http://195.30.4.1:23" rel=3D"noreferrer" target=
=3D"_blank">195.30.4.1:23</a><br>
<span><span>Sat Jun 11 22:23:51 2016</span></span> Send to HTTP proxy: &#39=
;CONNECT <a href=3D"http://10.0.0.1:51196" rel=3D"noreferrer" target=3D"_bl=
ank">10.0.0.1:51196</a> HTTP/1.0&#39;<br>
<span><span>Sat Jun 11 22:23:51 2016</span></span> Send to HTTP proxy: &#39=
;Host: 10.0.0.1&#39;<br>
<span><span>Sat Jun 11 22:24:10 2016</span></span> recv_line: TCP port read=
 timeout expired: Operation now in progress (errno=3D115)<br>
<span><span>Sat Jun 11 22:24:10 2016</span></span> SIGUSR1[soft,init_instan=
ce] received, process restarting<br>
<span><span>Sat Jun 11 22:24:10 2016</span></span> Restart pause, 5 second(=
s)<br>
[..]<br>
<span><span>Sat Jun 11 22:24:15 2016</span></span> Attempting to establish =
TCP connection with [AF_INET]<a href=3D"http://195.30.4.1:23" rel=3D"norefe=
rrer" target=3D"_blank">195.30.4.1:23</a> [nonblock]<br>
<br>
<br>
(Side note: you win the &quot;who knows more obscure/rarely used OpenVPN op=
tions&quot;<br>
contest today :-) )<br></blockquote><div><br></div><div>I respectfully decl=
ine to accept..:-) <br><br>I&#39;ve been scruitinizing every SIGsomething i=
n the code as a part of my foray into &quot;Signals in OpenVPN&quot;, saw t=
his option only the other day for the first time..<br></div><div>=C2=A0<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
<br>
I do wonder how useful these settings are, and why they are not default...<=
br>
they predate my OpenVPN involvement by many years.</blockquote></div><br></=
div><div class=3D"gmail_extra">No clue..<br><br></div><div class=3D"gmail_e=
xtra">Selva<br></div></div>

--001a1147f47e30c4c0053506c54b--

