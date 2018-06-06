MIME-Version: 1.0
In-Reply-To: <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...>
 <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 6 Jun 2018 16:28:04 -0400
Message-ID: <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
Content-Type: multipart/alternative; boundary="00000000000038bce8056dff021f"
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000038bce8056dff021f
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, Jun 6, 2018 at 11:40 AM, Selva Nair <selva.nair@...277...> wrote:
> Hi,
>
> On Wed, Jun 6, 2018 at 7:33 AM, Antonio Quartulli <a@...2181...> wrote:
>> Hi,
>>
>> On 06/06/18 04:30, Selva Nair wrote:
..

>>
>> I am not sure why you get those 2 routes. Do you have a more extensive
>> log to show? It may help clearing up some doubts.
>
> Don't have access to those logs right now -- will post later.

The logs are here:
https://gist.github.com/selvanair/fc8c74ce83bfa0c93aca8bec97dd091b
(sanitized). --redirect-gateway !ipv4 is in client config
(not pushed), no other routes in config or PUSH. ifconfig is rejected using
pull filter as seen in the logs.

Actually despite the "errors" the connection has succeeded, appearances to
the contrary.

It doesn't say anything more than what we already discussed, but may still
help.

Selva

--00000000000038bce8056dff021f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br><br>On Wed, Jun 6, 2018 at 11:40 AM, Selva Nair=
 &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...220...=
..277...</a>&gt; wrote:<br>&gt; Hi,<br>&gt;<br>&gt; On Wed, Jun 6, 2018 at =
7:33 AM, Antonio Quartulli &lt;a@...2181...&gt; wrote:<br>&gt;&gt; Hi,<br>&=
gt;&gt;<br>&gt;&gt; On 06/06/18 04:30, Selva Nair wrote:<br>..<br><br>&gt;&=
gt;<br>&gt;&gt; I am not sure why you get those 2 routes. Do you have a mor=
e extensive<br>&gt;&gt; log to show? It may help clearing up some doubts.<b=
r>&gt;<br>&gt; Don&#39;t have access to those logs right now -- will post l=
ater.<br><br>The logs are here:<br><a href=3D"https://gist.github.com/selva=
nair/fc8c74ce83bfa0c93aca8bec97dd091b" target=3D"_blank">https://gist.githu=
b.com/<wbr>selvanair/<wbr>fc8c74ce83bfa0c93aca8bec97dd09<wbr>1b</a><br>(san=
itized). --redirect-gateway !ipv4 is in client config<br>(not pushed), no o=
ther routes in config or PUSH. ifconfig is rejected using<br>pull filter as=
 seen in the logs.<br><br></div>Actually despite the &quot;errors&quot; the=
 connection has succeeded, appearances to the contrary.<br><div><br>It does=
n&#39;t say anything more than what we already discussed, but may still hel=
p.<br><br>Selva<br></div></div>

--00000000000038bce8056dff021f--

