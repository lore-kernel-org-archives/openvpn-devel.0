MIME-Version: 1.0
In-Reply-To: <4B4B9148.2070805@...1009...>
References: <edfc67860910281224x55ec531ala646a288c40641cf@...278...> 
	<4AE8A8A4.1040102@...1270...>
	<edfc67860910290441x73b13cc4g74be925b24a32d48@...278...> 
	<edfc67861001111143x438faf23r181370807c8e544c@...278...> 
	<4B4B9148.2070805@...1009...>
From: Lucas Mocellin <lucasmocellin@...277...>
Date: Tue, 12 Jan 2010 11:25:57 -0200
Message-ID: <edfc67861001120525j6352ec63s93d466e3ec315234@...278...>
Content-Type: multipart/alternative; boundary=0016e6d5669348a829047cf799e2
Subject: Re: [Openvpn-devel] How to check is OpenVPN port is open
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0016e6d5669348a829047cf799e2
Content-Type: text/plain; charset=ISO-8859-1

I have everything filtered. and the problem is that I should this from the
server, and that's not what I need, I need to check from the client if the
server is running. But probably this server works as NMAP or NC, look at
this part of man nmap:

UDP scan works by sending an empty (no data) UDP header to every targeted
port. If an ICMP port unreachable error (type 3, code 3) is
              returned, the port is closed. Other ICMP unreachable errors
(type 3, codes 1, 2, 9, 10, or 13) mark the port as filtered. Occasionally,
a
              service will respond with a UDP packet, proving that it is
open. If no response is received after retransmissions, the port is
classified
              as open|filtered. This means that the port could be open, or
perhaps packet filters are blocking the communication. Versions scan (-sV)
can
              be used to help differentiate the truly open ports from the
filtered ones.

On Mon, Jan 11, 2010 at 6:59 PM, Thomas Reifferscheid <
thomas@...1009...> wrote:

> Point your browser to http://www.utorrent.com/testport?port=1194
> to get an idea if there is a [openvpn] daemon listening on udp/1194
>
> HTH
> T
>
> Lucas Mocellin schrieb:
>
>  Hello,
>>
>> again I fell in this problem, I must solve this now, so if someone has a
>> better idea than trying to reproduce the OpenVPN protocol begin and see if
>> there is any answer, I will have to figure out how to send the OpenVPN
>> protocol by UDP manually.
>>
>> I would like to see if there is a simpler manner to check if OpenVPN is
>> listenning and accepting connections.
>>
> ...
>
>

--0016e6d5669348a829047cf799e2
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

I have everything filtered. and the problem is that I should this from the =
server, and that&#39;s not what I need, I need to check from the client if =
the server is running. But probably this server works as NMAP or NC, look a=
t this part of man nmap:<br>

<br>UDP scan works by sending an empty (no data) UDP header to every target=
ed port. If an ICMP port unreachable error (type 3, code 3) is<br>=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 returned, the port is closed. Other ICMP unr=
eachable errors (type 3, codes 1, 2, 9, 10, or 13) mark the port as filtere=
d. Occasionally, a<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 service will respond with a UDP pac=
ket, proving that it is open. If no response is received after retransmissi=
ons, the port is classified<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 as o=
pen|filtered. This means that the port could be open, or perhaps packet fil=
ters are blocking the communication. Versions scan (-sV) can<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 be used to help differentiate the t=
ruly open ports from the filtered ones.<br><br><div class=3D"gmail_quote">O=
n Mon, Jan 11, 2010 at 6:59 PM, Thomas Reifferscheid <span dir=3D"ltr">&lt;=
<a href=3D"mailto:thomas@...1009...">thomas@...1009...</a>&gt;</span> wrote=
:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Point your browse=
r to <a href=3D"http://www.utorrent.com/testport?port=3D1194" target=3D"_bl=
ank">http://www.utorrent.com/testport?port=3D1194</a><br>


to get an idea if there is a [openvpn] daemon listening on udp/1194<br>
<br>
HTH<br>
T<br>
<br>
Lucas Mocellin schrieb:<div class=3D"im"><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hello,<br>
<br>
again I fell in this problem, I must solve this now, so if someone has a be=
tter idea than trying to reproduce the OpenVPN protocol begin and see if th=
ere is any answer, I will have to figure out how to send the OpenVPN protoc=
ol by UDP manually.<br>


<br>
I would like to see if there is a simpler manner to check if OpenVPN is lis=
tenning and accepting connections.<br>
</blockquote></div>
...<br>
<br>
</blockquote></div><br>

--0016e6d5669348a829047cf799e2--

