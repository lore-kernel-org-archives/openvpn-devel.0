MIME-Version: 1.0
In-Reply-To: <4AE8A8A4.1040102@...1270...>
References: <edfc67860910281224x55ec531ala646a288c40641cf@...278...> 
	<4AE8A8A4.1040102@...1270...>
From: Lucas Mocellin <lucasmocellin@...277...>
Date: Thu, 29 Oct 2009 09:41:29 -0200
Message-ID: <edfc67860910290441x73b13cc4g74be925b24a32d48@...278...>
Content-Type: multipart/alternative; boundary=0016e6d784e313d6e60477116650
Subject: Re: [Openvpn-devel] How to check is OpenVPN port is open
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0016e6d784e313d6e60477116650
Content-Type: text/plain; charset=ISO-8859-1

Hi again,

I forgot to say that I'm working with UDP, and all the problem is around
this protocol connectionless.

I tried to sniff and redo the "connection start", but always the packages
are different but actually, I didn't figured it out completely, and probably
I won't studi the OpenVPN protocol deeply right now for that.

ngrep:
#
U 2009/10/29 09:33:07.954515 192.168.9.129:57691 -> 192.168.9.127:1194
  8..Rao.T..........
#
U 2009/10/29 09:33:07.955865 192.168.9.127:1194 -> 192.168.9.129:57691

@6..............Rao.T.....

#
U 2009/10/29 09:33:07.956913 192.168.9.129:57691 -> 192.168.9.127:1194

(..Rao.T......6.......


the first packet always start with an "8" and has a fixed lenght of 18
characters:
8.....7U..........
8..XyR............
8......h..........

but I don't know if I just can send this "info" like a string creating a UDP
socket, I tried and it didn't work, maybe some mistake, I can try again.

I can't just start an OpenVPN because I don't have the key yet, this
verification is done before the OpenVPN connection.

I got this from another FORUM:
"The trouble with verifying UDP ports as open is that if a UDP port is
open, you get no response from it.  That's also the case when it's
filtered of course. "

I understand but not at all, if there is no response, there is no
communication.. hehe

another manner of how to check if an OpenVPN UDP port is open?

Thanks for the answers folks!

Lucas.

On Wed, Oct 28, 2009 at 6:25 PM, Yevgeny Kosarzhevsky <yevg@...1270...>wrote:

> Hi,
>
>
> Lucas Mocellin wrote:
>
>> Hi all,
>>
>> briefly: I'm helping in the development of an educational software to
>> apply online tests. The client will connect to the server through OpenVPN to
>> perform the test. I would like to check if the OpenVPN port is alive and
>> accepting connections (check if there is port filtering, and so on.. ).
>>
>> I'm programming in python.
>>
>> Does someone know to achieve that? I'm trying to create a socket and send
>> any message to the server, but no response, is there any kind of "hello" or
>> something like this?
>>
>
> You can test it with netcat utility which is run on the server in listen
> mode and on client in client mode.
>

--0016e6d784e313d6e60477116650
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi again,<br><br>I forgot to say that I&#39;m working with UDP, and all the=
 problem is around this protocol connectionless.<br><br>I tried to sniff an=
d redo the &quot;connection start&quot;, but always the packages are differ=
ent but actually, I didn&#39;t figured it out completely, and probably I wo=
n&#39;t studi the OpenVPN protocol deeply right now for that.<br>

<br>ngrep:<br>#<br>U 2009/10/29 09:33:07.954515 <a href=3D"http://192.168.9=
.129:57691">192.168.9.129:57691</a> -&gt; <a href=3D"http://192.168.9.127:1=
194">192.168.9.127:1194</a><br>=A0 8..Rao.T.......... <br>#<br>U 2009/10/29=
 09:33:07.955865 <a href=3D"http://192.168.9.127:1194">192.168.9.127:1194</=
a> -&gt; <a href=3D"http://192.168.9.129:57691">192.168.9.129:57691</a><br>

=A0 @6..............Rao.T.....=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>#<br>U 2009/10/29 09:33:07.956913 <a href=
=3D"http://192.168.9.129:57691">192.168.9.129:57691</a> -&gt; <a href=3D"ht=
tp://192.168.9.127:1194">192.168.9.127:1194</a><br>

=A0 (..Rao.T......6.......=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br><br>the first packet always =
start with an &quot;8&quot; and has a fixed lenght of 18 characters:<br>8..=
...7U..........<br>

8..XyR............<br>8......h..........<br><br>but I don&#39;t know if I j=
ust can send this &quot;info&quot; like a string creating a UDP socket, I t=
ried and it didn&#39;t work, maybe some mistake, I can try again.<br><br>

I can&#39;t just start an OpenVPN because I don&#39;t have the key yet, thi=
s verification is done before the OpenVPN connection.<br><br>I got this fro=
m another FORUM:<br>&quot;The trouble with verifying UDP ports as open is t=
hat if a UDP port is <br>

 open, you get no response from it. =A0That&#39;s also the case when it&#39=
;s <br> filtered of course. &quot;<br><br>I understand but not at all, if t=
here is no response, there is no communication.. hehe<br><br>another manner=
 of how to check if an OpenVPN UDP port is open?<br>

<br>Thanks for the answers folks!<br><br>Lucas.<br><br><div class=3D"gmail_=
quote">On Wed, Oct 28, 2009 at 6:25 PM, Yevgeny Kosarzhevsky <span dir=3D"l=
tr">&lt;<a href=3D"mailto:yevg@...1270...">yevg@...1270...</a>&gt;</span> w=
rote:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<div class=3D"=
im"><br>
<br>
Lucas Mocellin wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi all,<br>
<br>
briefly: I&#39;m helping in the development of an educational software to a=
pply online tests. The client will connect to the server through OpenVPN to=
 perform the test. I would like to check if the OpenVPN port is alive and a=
ccepting connections (check if there is port filtering, and so on.. ).<br>


<br>
I&#39;m programming in python.<br>
<br>
Does someone know to achieve that? I&#39;m trying to create a socket and se=
nd any message to the server, but no response, is there any kind of &quot;h=
ello&quot; or something like this?<br>
</blockquote>
<br></div>
You can test it with netcat utility which is run on the server in listen mo=
de and on client in client mode.<br>
</blockquote></div><br>

--0016e6d784e313d6e60477116650--

