References: <57A3C76A.1020809@...277...>
	<CAKuzo_h0vMR4jv=iAgT2Vr2kq-nJRDs0Pq=3JC7eydQ-m1Ucpw@...278...>
	<f9d8f147-e3d1-b80b-5646-faba6b853bc2@...277...>
	<76eb908d-b7b3-7425-5340-e4cd5726fbd1@...2080...>
	<3642cff2-6233-0a28-2a39-36513f008ab4@...277...>
	<20160823123439.GA78279@...1296...> <57BD5780.2030204@...1147...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <f65edd44-e931-46e8-d21d-deda38005718@...515...>
Date: Wed, 24 Aug 2016 11:45:55 +0300
MIME-Version: 1.0
In-Reply-To: <57BD5780.2030204@...1147...>
Subject: Re: [Openvpn-devel] Win10 Tun Server +Standard W10 User +OVPN
 Interactive Service +OVPN GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Il 24/08/2016 11:14, Jan Just Keijser ha scritto:
> Hi,
>
> On 23/08/16 14:34, Gert Doering wrote:
>> On Tue, Aug 23, 2016 at 01:55:23AM +0100, debbie10t wrote:
>>> I need to use --up/--down/--client-connect/disconnect et al ..
>> You can, but they will run with the user privileges of the user that
>> runs openvpn-gui by default.  If you need more privileges, you need
>> to run openvpn.exe or the gui with admin privs.
>>
>>> How does one run openvpn on *windows* without these "considered"
>>> security flaws ? or are we all just "lambs to the slaughter"
>>> from here on in ?
>> You can use openvpnserv2 to run openvpn.exe with admin privs (and no
>> gui), or you can set [x] run as admin on the openvpn-gui (as it was done
>> for 2.3.x).
>>
>> Most people on windows only need privileges to add/delete routes and
>> configure IP addresses - this is what the iservice will give you, without
>> the potential dangers of running openvpn and all scripts with full
>> admin privs.
>>
> just for my understanding: how would a user run an up/down script with
> *USER* credentials (necessary to map a share or printer, for example) in
> this scenario?

You mean when running OpenVPN-GUI as admin, but wanting the map a share=20
as a non-privileged user?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

