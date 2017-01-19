References: <b3afdbf7-ee12-3c1f-b8cd-c30cf3b0a025@...75...>
	<20170118193527.GT78624@...1296...>
From: =?UTF-8?Q?Thomas_Sch=c3=a4fer?= <tschaefer@...75...>
Message-ID: <fe421f51-e376-15e5-274c-fa6a62cc6dfe@...75...>
Date: Thu, 19 Jan 2017 14:42:18 +0100
MIME-Version: 1.0
In-Reply-To: <20170118193527.GT78624@...1296...>
Subject: Re: [Openvpn-devel] NOTE: unable to redirect default gateway --
 Cannot read current default gateway from system
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 18.01.2017 um 20:35 schrieb Gert Doering:
> Servus,
>
> On Wed, Jan 18, 2017 at 04:43:22PM +0100, Thomas Sch=C3=A4fer wrote:
>> Client:
>> client
>> dev tun
>> proto udp6
>> remote raspberrypi.XXXXXXXX.myfritz.net 1194 udp6
> [..]
>> redirect-gateway
>> verb 3
>>
>> This works perfectly as long the client has still an IPv4-connection.
>>
>> But in case of an IPv6-only-client (not system-wide disabled, just not
>> getting IPv4-addresses by the ISP, e.g. eduroam-IPv6) the client doesn't
>> set the IPv4-default route, since it can not find the old one.
>
> I can see the problem.
>
> The most elegant solution might be to use "redirect-gateway def1".   The
> "def1" flag instructs the code to not add a 0.0.0.0/0 route (replacing
> and later restoring the existing default route) but to add 0.0.0.0/1 and
> 128.0.0.0/1 routes - which cover "the default" as well, but do not
> need to interfere with the existing /0 route.


This did not work. Same error as before.


>
> In case "def1" is not enough, please try "redirect-gateway def1 local",
> which is a hack (but a documented one).  "local" signals "do not install
> a host route pointing to the default gateway, because the VPN server is
> in the same locally connected network" (think "university wifi").  So that
> should make things succeed.

This did not work. Same error as before.

>
>
> If that is still not working, use brute force, and replace "redirect-gate=
way"
> with
>
>   route 0.0.0.0/1
>   route 128.0.0.0/1

This leads to:

Thu Jan 19 14:10:43 2017 RESOLVE: Cannot resolve host address:=20
128.0.0.0/1: (Name or service not known)
Thu Jan 19 14:10:43 2017 OpenVPN ROUTE: failed to parse/resolve route=20
for host/network: 128.0.0.0/1
Thu Jan 19 14:10:43 2017 RESOLVE: Cannot resolve host address:=20
0.0.0.0/1: (Name or service not known)
Thu Jan 19 14:10:43 2017 OpenVPN ROUTE: failed to parse/resolve route=20
for host/network: 0.0.0.0/1



>
> in the client config - that is the same thing as "def1 local" should give
> you, but explicitely only the "two half-default routes".

But

route   0.0.0.0 128.0.0.0
route 128.0.0.0 128.0.0.0


works.


Thomas




