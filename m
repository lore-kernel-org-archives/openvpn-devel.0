MIME-Version: 1.0
In-Reply-To: <20160611181434.GT62247@...1296...>
References: <0d1ed9a2-71f4-f791-3633-9937b3764de1@...1227...>
	<1465656195-12722-1-git-send-email-arne@...1227...>
	<20160611181434.GT62247@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 11 Jun 2016 14:47:47 -0400
Message-ID: <CAKuzo_gJLLjMWM7RRP=QzHBAEA6==f1BhEEa8gjL2W_FcGN-5A@...278...>
Content-Type: multipart/alternative; boundary=001a11412794939e7605350518e2
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

--001a11412794939e7605350518e2
Content-Type: text/plain; charset=UTF-8

On Sat, Jun 11, 2016 at 2:14 PM, Gert Doering <gert@...1296...> wrote:

> One thing I noticed when testing which is not *caused* by this patch but
> which you/we might want to fix while at it.
>
> When talking to a "deaf" HTTP proxy - namely, one that accepts the TCP
> connect, but then never sends back anything (try 195.30.4.1:23, it's
> a "Teergrube" to annoy wannabe hackers) the timeout will fire at the
> correct interval - 25s in my test, but then it won't restart but exit:
>
> Sat Jun 11 20:05:59 2016 Attempting to establish TCP connection with
> [AF_INET]195.30.4.1:23 [nonblock]
> Sat Jun 11 20:06:00 2016 TCP connection established with [AF_INET]
> 195.30.4.1:23
> Sat Jun 11 20:06:00 2016 Send to HTTP proxy: 'CONNECT 10.0.0.1:51196
> HTTP/1.0'
> Sat Jun 11 20:06:00 2016 Send to HTTP proxy: 'Host: 10.0.0.1'
> Sat Jun 11 20:06:24 2016 recv_line: TCP port read timeout expired:
> Operation now in progress (errno=115)
> Sat Jun 11 20:06:24 2016 SIGTERM[soft,init_instance] received, process
> exiting
>


Isn't this controlled by the http-proxy-retry option which is off by
default? Set that in the config and SIGUSR1 restart should happen, I
think...

Selva

--001a11412794939e7605350518e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Jun 11, 2016 at 2:14 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div>One thing I noticed when te=
sting which is not *caused* by this patch but<br>
which you/we might want to fix while at it.<br>
<br>
When talking to a &quot;deaf&quot; HTTP proxy - namely, one that accepts th=
e TCP<br>
connect, but then never sends back anything (try <a href=3D"http://195.30.4=
.1:23" rel=3D"noreferrer" target=3D"_blank">195.30.4.1:23</a>, it&#39;s<br>
a &quot;Teergrube&quot; to annoy wannabe hackers) the timeout will fire at =
the<br>
correct interval - 25s in my test, but then it won&#39;t restart but exit:<=
br>
<br>
<span><span>Sat Jun 11 20:05:59 2016</span></span> Attempting to establish =
TCP connection with [AF_INET]<a href=3D"http://195.30.4.1:23" rel=3D"norefe=
rrer" target=3D"_blank">195.30.4.1:23</a> [nonblock]<br>
<span><span>Sat Jun 11 20:06:00 2016</span></span> TCP connection establish=
ed with [AF_INET]<a href=3D"http://195.30.4.1:23" rel=3D"noreferrer" target=
=3D"_blank">195.30.4.1:23</a><br>
<span><span>Sat Jun 11 20:06:00 2016</span></span> Send to HTTP proxy: &#39=
;CONNECT <a href=3D"http://10.0.0.1:51196" rel=3D"noreferrer" target=3D"_bl=
ank">10.0.0.1:51196</a> HTTP/1.0&#39;<br>
<span><span>Sat Jun 11 20:06:00 2016</span></span> Send to HTTP proxy: &#39=
;Host: 10.0.0.1&#39;<br>
<span><span>Sat Jun 11 20:06:24 2016</span></span> recv_line: TCP port read=
 timeout expired: Operation now in progress (errno=3D115)<br>
<span><span>Sat Jun 11 20:06:24 2016</span></span> SIGTERM[soft,init_instan=
ce] received, process exiting</div></blockquote></div><br><br></div><div cl=
ass=3D"gmail_extra">Isn&#39;t this controlled by the http-proxy-retry optio=
n which is off by=C2=A0 default? Set that in the config and SIGUSR1 restart=
 should happen, I think...<br><br></div><div class=3D"gmail_extra">Selva <b=
r></div></div>

--001a11412794939e7605350518e2--

