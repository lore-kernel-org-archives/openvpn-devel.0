Message-ID: <4F9A8A3F.3020008@...515...>
Date: Fri, 27 Apr 2012 14:59:59 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz15xpgFxzqQFaotZSmS2=-gSmUsMMwy=SZay6bi3EEMAg@...278...>
	<1332621070-28464-1-git-send-email-alon.barlev@...277...>
	<4F9A5EB7.902@...515...> <2620278.PZKTmmtf1E@...1526...>
	<4F9A8928.9080703@...515...>
In-Reply-To: <4F9A8928.9080703@...515...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: windows: convert argv (UCS-2
 to UTF-8) at earliest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Heiko Hund <heiko.hund@...1489...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Il 27.04.2012 12:18, Heiko Hund ha scritto:
>> On Friday 27 April 2012 09:54:15 Samuli Sepp=E4nen wrote:
>>> Anyways, I cross-compiled latest "master" with this patch applied and
>>> "bin" and "lib" directories on top of an existing openvpn-2.3-alpha1
>>> install. The old "bin" directory was renamed to make sure none of it was
>>> used. I then renamed "openvpn.ovpn" to "=E4=E4li=F6.ovpn" and "ta.key" =
to
>>> "=E4=E4li=F6.key" using Windows Explorer. Then I updated the configurat=
ion
>>> file to point to these files using Notepad (and later Wordpad).
>> Notepad saves UTF-8 files with BOM, which is very uncommon. Maybe that w=
as the=20
>> problem. I ran into that when I was testing my patch. You might want to =
try=20
>> using Notepad++ and save it as UTF-8 without BOM.
>>
>> HTH
>> Heiko
> Saved the configuration file to UTF-8 without BOM - after this I got no
> complaints from OpenVPN-GUI. Launching OpenVPN from the command prompt
> also worked... tls-auth was undefined in the config, and openvpn called
> like this:
>
>> openvpn --config =E4=E4li=F6.ovpn --tls-auth =E4=E4li=F6.key 1
> Only minor issue was that the command prompt displayed funky characters
> instead of the proper ones:
>
> <http://users.utu.fi/sjsepp/cmd2.png>
>
> Thanks for the tip, Heiko!
>

OpenVPN 2.3-alpha1 also behaves in the exactly same way. Is that to be
expected?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


