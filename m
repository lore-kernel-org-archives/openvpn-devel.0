References: <22a91a88-9555-ef6a-2941-22adfc7f9788@...515...>
 <2545808.mvXUDI8C0e@...2258...> <20200901201428.GH75094@...1296...>
From: =?UTF-8?Q?Thomas_Sch=c3=a4fer?= <tschaefer@...75...>
Message-ID: <c379e529-63a4-c4a0-29e2-fcf4260cc32c@...75...>
Date: Wed, 2 Sep 2020 10:03:11 +0200
MIME-Version: 1.0
In-Reply-To: <20200901201428.GH75094@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] OpenVPN 2.5-beta3 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 01.09.20 um 22:14 schrieb Gert Doering:
> Hi,
> 
> On Tue, Sep 01, 2020 at 08:07:20PM +0200, Thomas Schäfer wrote:
>>>      - IPv4-only VPN
>> Typo?
> 
> We can do that!

Is it new in 2.5?

Asking again, just to understand the difference

  "IPv6-only operation"
I can remove all IPv4-related config

and

  "IPv4-only VPN"
means better protection to prevent IPv6-leaks in an intended IPv4-only 
operation mode

positive test feedback:

I tested yesterday my setup with with 2.5beta3

linux as server (2.5beta3)
android as client
Windows 10 (2.5beta3) as client

transport: IPv6 only,
payload: IPv4/IPv6 with redirecting all traffic.

It (still) works.

Thank You!


Thomas

