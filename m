References: <cc7faf4a-5c6e-fe03-01c3-8446faddf4a9@...2318...>
 <YQz+yKSrysYMoxwS@...1296...>
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
Message-ID: <d3a27282-083e-d5fc-8866-b92610345125@...2318...>
Date: Fri, 6 Aug 2021 12:50:44 +0200
MIME-Version: 1.0
In-Reply-To: <YQz+yKSrysYMoxwS@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] IPv6 client IP pool configuration issues
 (2.4/2.5)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 06.08.21 11:20, Gert Doering wrote:
> Hi,

Hi Gert,

> On Fri, Aug 06, 2021 at 10:38:36AM +0200, Fran=E7ois Kooman wrote:
>> However, it does not explain how it exactly would rewrite --server-ipv6
>> fd42::/112 to those three statements.
>>
>> --ifconfig-ipv6 fd42::1/112 <????>
>> --ifconfig-ipv6-pool fd42::1000/112
>> --push "tun-ipv6"
>=20
> This should work.  And you can leave off the "push" bit :-)

Ah right, that is implicit now (OpenVPN >=3D 2.4): "All tun devices on all =

platforms are always considered to be IPv6 capable. The --tun-ipv6=20
option is ignored (behaves like it is always on)."

> A random IP in that subnet, like "fd42::1/112 fd42::2" - this is a
> somewhat unlucky artefact of the implementation of --ifconfig-ipv6,
> which insists on having a "remote" even if that is not used in
> many cases.

Right, I'll set it to the same IP as the tun0 device itself, i.e.=20
fd42::1 if it can be random anyway ;-)

> Without having tested it, I would agree that this is what it is.

Actually I did test it now properly and it does work!

> (The reason it was changed from :1000 to ::2 is "small pool size" -
> if you have only a /112 or smaller, starting from :1000 reduces the pool
> size significantly.  If you use a /111 or bigger, it will actually stick
> to the old behaviour - see helper.c, around line 200)

Right, thanks for the explanation!

> The log snippet is too short to give meaningful advice.  Please show
> the "ifconfig" or "ip address" statements, and what (if anything) is
> pushed to clients.

I actually screwed up my iptables rules that made it break because of=20
different pool configuration (duh). So stupid :-(

Thanks for your reply and confirming it works like this! :-)

Regards,
Fran=E7ois

