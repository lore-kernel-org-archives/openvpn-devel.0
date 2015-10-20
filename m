References: <56211F0D.2010806@...515...> <2892922.l0hsuaC9oU@...2001...>
	<5625EA0A.3000908@...515...> <2421664.qQJpUDo69u@...1526...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56261F0D.9020208@...515...>
Date: Tue, 20 Oct 2015 14:01:33 +0300
MIME-Version: 1.0
In-Reply-To: <2421664.qQJpUDo69u@...1526...>
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net


> On Tuesday 20 October 2015 10:15:22 Samuli Sepp=C3=A4nen wrote:
>>>> Are you saying that the interactive service also doubles as a Windows
>>>> system service? If so, can it be  configured to autostart selected
>>>> openvpn connections on boot and restart them if they crash/stop?
>>>
>>> No, and I do not think that the service should take care of that. That's
>>> rather things that can be handled by the GUI.
>>
>> What about persistent connections, especially on Windows servers?
>
> The interactive service patch doesn't remove the currently available serv=
ice.
> So, you still can fire up any connections the way it was before. I person=
ally
> do not care about the original service though, it may very well be that it
> lacks decent functionality.

The original openvpnserv.exe is truly crappy. It will not quit if all=20
connections have died. It will not restart a connection should it crash.=20
A single non-functional OpenVPN connection prevents it from launching=20
the others (afaik). It will not work on Windows 10 in any reasonable=20
fashion and works badly on anything post-Windows 7. It also does not=20
handle resuming from suspend/hibernate properly.

My NSSM-based replacement thingie aims to address all these=20
shortcomings. I believe the interactive service and NSSM are complementary.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

