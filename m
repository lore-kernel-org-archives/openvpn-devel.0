MIME-Version: 1.0
References: <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
 <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
 <665fcdae-dad7-b6c8-14ee-512ff7992963@...2181...>
 <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>
 <20180607165705.GP57262@...1296...>
 <CAKuzo_j23Y5Q367cug-usSheh5h6WXUqswOqNBVS3073rMesVw@...278...>
 <f0a67a1c-8103-5db9-44b2-7f4c82dc70a8@...2181...>
 <CAKuzo_hSmy3qOLOVUtDrKgewPW4CKOu6Sd73FJkweBXMWBwgmw@...278...>
 <bcb2d941-f436-d900-9826-1dac9ef33949@...2181...>
In-Reply-To: <bcb2d941-f436-d900-9826-1dac9ef33949@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 8 Jun 2018 00:24:40 -0400
Message-ID: <CAKuzo_gHoxHHH0XeYzZ6DKOaC5F_G8-fzCHhxhfLXm78VbdE4Q@...278...>
Content-Type: multipart/alternative; boundary="0000000000000678de056e19c8c7"
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000000678de056e19c8c7
Content-Type: text/plain; charset="UTF-8"

Hi,


> > [*] Topology subnet uses ip, nework and netmask, while net30 passes in
> the
> > second IP of the /30 in network as "netmask". The two ioctls interprets
> > their parameters differently such that in the end only valid ARP packets
> > get a response from the driver !
>
> Is ARP still to be considered when no IPv4 is configured?
>

No, but we only have one ioctl (well two with slightly different syntax) to
setup the tap driver which uses the v4 info we pass in for setting up ARP
data as well as a few other things. So unless we patch the tap driver we
are stuck with some convoluted code. I was only suggesting not to touch it
unless we are improving the code.

I'm still hoping that one day we may be able to treat Windows like other
platforms. And then did_ifconfig_setup = false would only mean ifconfig is
not in the config (or pushed) which is not the same as v4 is disabled.

Anyway, I'll leave it at that.

Selva

--0000000000000678de056e19c8c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>Hi,</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
&gt; [*] Topology subnet uses ip, nework and netmask, while net30 passes in=
 the<br>
&gt; second IP of the /30 in network as &quot;netmask&quot;. The two ioctls=
 interprets<br>
&gt; their parameters differently such that in the end only valid ARP packe=
ts<br>
&gt; get a response from the driver !<br>
<br>
Is ARP still to be considered when no IPv4 is configured?<br></blockquote><=
div><br></div><div>No, but we only have one ioctl (well two with slightly d=
ifferent syntax) to setup the tap driver which uses the v4 info we pass in =
for setting up ARP data as well as a few other things. So unless we patch t=
he tap driver we are stuck with some convoluted code. I was only suggesting=
 not to touch it unless we are improving the code.</div><div><br></div><div=
>I&#39;m still hoping that one day we may be able to treat Windows like oth=
er platforms. And then did_ifconfig_setup =3D false would only mean ifconfi=
g is not in the config (or pushed) which is not the same as v4 is disabled.=
</div><div><br></div><div>Anyway, I&#39;ll leave it at that.</div><div><br>=
</div><div>Selva</div></div></div>

--0000000000000678de056e19c8c7--

