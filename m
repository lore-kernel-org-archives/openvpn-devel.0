MIME-Version: 1.0
In-Reply-To: <4FA8F1E2.6080604@...1114...>
References: <CAArKS8hPVLQSNrX4HtB+6UA+UU-63PmyN0BNmFuPdu4W0ZFEMw@...278...>
	<4FA8F1E2.6080604@...1114...>
From: Tom Kent <lists@...1718...>
Date: Tue, 8 May 2012 09:50:12 -0400
Message-ID: <CAArKS8hNQ+xE-o90wKNLO9LPk3kQbz8EGhrVJATeY7HjpO9s=w@...278...>
Content-Type: multipart/alternative; boundary=0015175889c29f46f304bf86abdc
Subject: Re: [Openvpn-devel] OpenVPN in the Hypervisor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0015175889c29f46f304bf86abdc
Content-Type: text/plain; charset=ISO-8859-1

> But... I don't think that OpenVPN is the right approach as it is not peer-to-peer
solution.

I agree that this is not the optimal solution, especially for large/high
bandwith setups. I was just looking for something that I could get going
with what I have today. My ideal setup would be a central arbiter that
hands out routing and encryption info each for each p2p connection that is
desired, but I don't know of anything that does this currently.

> If your hypervisor uses a tap interface, you can just have openvpn use
that tap interface "right away".

I guess I need to read up a bit more on how tap interfaces work. I guess I
assumed that the hypervisor was controlling that, so there wouldn't be room
for openvpn to jump on it. But assuming it is as you say, that seems very
promising, and much easier to get going than I though.

I think I'm going to try this out here in the next few days, and see how
easily I can get something setup. If I have luck I'll put up a blog post
about it.

Thanks for the input,
Tom

--0015175889c29f46f304bf86abdc
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

&gt;=A0<span>But... I don&#39;t think that OpenVPN is the right approach as=
 it is not=A0</span><span>peer-to-peer solution.</span><div><span><br></spa=
n></div><div><span>I agree that this is not the optimal solution, especiall=
y for large/high bandwith setups. I was just looking for something that I c=
ould get going with what I have today. My ideal setup would be a central ar=
biter that hands out routing and encryption info each for each p2p connecti=
on that is desired, but I don&#39;t know of anything that does this current=
ly.=A0</span></div>


<div><span><br></span></div><div><span>&gt;=A0</span><span>If your hypervis=
or uses a tap interface, you can just have openvpn use</span></div><span>th=
at tap interface &quot;right away&quot;.</span><div>
<span><br></span></div><div><span>I guess I need to read up a bit more on h=
ow tap interfaces work. I guess I assumed that the hypervisor was controlli=
ng that, so there wouldn&#39;t be room for openvpn to jump on it. But assum=
ing it is as you say, that seems very promising, and much easier to get goi=
ng than I though. =A0</span></div>

<div><span><br></span></div><div><span>I think I&#39;m going to try this ou=
t here in the next few days, and see how easily I can get something setup. =
If I have luck I&#39;ll put up a blog post about it.</span></div><div>
<span><br>
</span></div><div><span>Thanks for the input,</span></div><div><span>Tom</s=
pan></div>

--0015175889c29f46f304bf86abdc--

