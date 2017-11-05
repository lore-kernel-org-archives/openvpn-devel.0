MIME-Version: 1.0
In-Reply-To: <a3d45ab2-63e9-2849-6118-775a8f43ec87@...1147...>
References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
 <41c0e750-b27e-22ea-d5fb-b17fe391636d@...1147...>
 <689096e2-8bb8-95b8-5daf-22fd600a00ca@...515...>
 <da7671c8-6768-f718-79a0-996cdb0d8d87@...1147...>
 <82ec1478-ec53-3980-05b1-4529a74aa789@...1147...>
 <20170717121451.GQ70062@...1296...>
 <a3d45ab2-63e9-2849-6118-775a8f43ec87@...1147...>
From: Selva <selva.nair@...277...>
Date: Sun, 5 Nov 2017 12:36:31 -0500
Message-ID: <CAKuzo_gd_T-mNYnLTy5dgb3G94cNci7Cs1ohVpCz2EwUcu6TWg@...278...>
Content-Type: multipart/alternative; boundary="001a114e65087c511f055d3fc892"
Subject: Re: [Openvpn-devel] Windows installer with updated pkcs11-helper
 (1.22) available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114e65087c511f055d3fc892
Content-Type: text/plain; charset="UTF-8"

Hi,

And the rationale for the patch:

On Mon, Jul 17, 2017 at 8:22 AM, Jan Just Keijser <janjust@...1147...> wrote:

> On 17/07/17 14:14, Gert Doering wrote:
>
>> Hi,
>>
>> On Mon, Jul 17, 2017 at 02:10:11PM +0200, Jan Just Keijser wrote:
>>
>>> this problem is NOT present in OpenVPN 2.3.17; the same warning appears
>>> (route gateway is ambiguous) but the route is added
>>> anyway. This seems to be a regression in 2.4.
>>>
>> Can we have a log, please?
>>
>>
>> attached: config and log (with hostnames anonymized)


As in the logs,

Mon Jul 17 14:18:43 2017 us=1227 C:\Windows\system32\route.exe ADD
222.222.97.13 MASK 255.255.255.255 111.111.135.254
Mon Jul 17 14:18:43 2017 us=1227 Warning: route gateway is ambiguous:
111.111.135.254 (2 matches)

when multiple interfaces match a route, we bail out with a warning unless
the route method used is exe. This code is the same in 2.3.17 and 2.4.3
except the latter defaults to using IPAPI invoked via the service. 2.3.7
also defaults to IPAPI but falls back to exe if the former fails.

Looking the sources: In tun.c
adapter_index_of_ip() returns the index of the first matching adapter and
the number of matching adapters found. If the count is > 1
windows_route_find_if_index() in route.c sets the index to
TUN_ADAPTER_INDEX_INVALID and route addition gets aborted.

We could slightly modify adapter_index_of_ip() to return the matching index
with smallest metric when more than one are found.

Selva

--001a114e65087c511f055d3fc892
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>And the rationale for the patch:<br=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Jul 17, =
2017 at 8:22 AM, Jan Just Keijser <span dir=3D"ltr">&lt;<a href=3D"mailto:j=
anjust@...1147..." target=3D"_blank">janjust@...1147...</a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"m_-6=
21741718886860131m_1830476516909612025m_5075951453959005665gmail-">On 17/07=
/17 14:14, Gert Doering wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Hi,<br>
<br>
On Mon, Jul 17, 2017 at 02:10:11PM +0200, Jan Just Keijser wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
this problem is NOT present in OpenVPN 2.3.17; the same warning appears (ro=
ute gateway is ambiguous) but the route is added<br>
anyway. This seems to be a regression in 2.4.<br>
</blockquote>
Can we have a log, please?<br>
<br>
<br>
</blockquote></span>
attached: config and log (with hostnames anonymized)</blockquote><div><br><=
/div><div>As in the logs,</div><div><div><br></div><div><div>Mon Jul 17 14:=
18:43 2017 us=3D1227 C:\Windows\system32\route.exe ADD 222.222.97.13 MASK 2=
55.255.255.255 111.111.135.254</div><div>Mon Jul 17 14:18:43 2017 us=3D1227=
 Warning: route gateway is ambiguous: 111.111.135.254 (2 matches)</div></di=
v><div><br></div><div>when multiple interfaces match a route, we bail out w=
ith a warning unless the route method used is exe. This code is the same in=
 2.3.17 and 2.4.3 except the latter defaults to using IPAPI invoked via the=
 service. 2.3.7 also defaults to IPAPI but falls back to exe if the former =
fails.=C2=A0<br></div><div><br></div><div>Looking the sources: In tun.c</di=
v><div>adapter_index_of_ip() returns the index of the first matching adapte=
r and the number of matching adapters found. If the count is &gt; 1<br></di=
v><div>windows_route_find_if_index() in route.c sets the index to TUN_ADAPT=
ER_INDEX_INVALID and route addition gets aborted.</div><div><br></div><div>=
We could slightly modify adapter_index_of_ip() to return the matching index=
 with smallest metric when more than one are found.</div><div><br></div><di=
v>Selva<br></div></div></div></div></div></div>

--001a114e65087c511f055d3fc892--

