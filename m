References: <56936C78.3020505@...515...>
	<5693BE57.2020505@...2080...>
	<20160111152253.GX24952@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5693EB68.3000504@...515...>
Date: Mon, 11 Jan 2016 19:50:32 +0200
MIME-Version: 1.0
In-Reply-To: <20160111152253.GX24952@...1296...>
Subject: Re: [Openvpn-devel] Disabling auth_pam plugin by default in
 openvpn-build?
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net


> Hi,
>
> On Mon, Jan 11, 2016 at 03:38:15PM +0100, David Sommerseth wrote:
>> You'll most likely upset quite some Linux distro maintainers.
>> Especially if such a change is not properly communicated.
>>
>> I know at least RPM packaging will start failing when it detects that
>> files expected to be installed by 'make install' is missing.  Other
>> packaging systems may behave differently.
>
> I would be very surprised to see "standard" distro maintainers use the
> openvpn-build script set - as it's totally unneeded unless you do
> cross-building...

Yeah, exactly. This might one of those "ask around in vain, then turn it=20
off, and suddenly everyone is complaining". I have no strong feelings=20
one way or the other.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

