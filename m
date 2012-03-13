Message-ID: <4F5F4279.80303@...515...>
Date: Tue, 13 Mar 2012 14:50:01 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...> <4F5E08D2.2040302@...515...>
	<CAOazyz0mnZZVbGiMxmkn_JW5+yZ8AUeejeVWi0pMbu9okieRpw@...278...>
	<70094734.yG4fYDZvM3@...1526...>
In-Reply-To: <70094734.yG4fYDZvM3@...1526...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
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
Cc: Alon Bar-Lev <alon.barlev@...277...>, =?ISO-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi
>
> On Monday 12 March 2012 19:01:41 Alon Bar-Lev wrote:
>> Although I tried to go farther... that what James suggested.
>> What is the baseline? This what we should agree first...
>> Should openvpn daemon be run on completely unprivileged account or not.
> I don't support the idea about running openvpn.exe with elevated privileg=
es.=20
> It has been run as the user before and that worked fine until Microsoft=20
> limited access to system resources in Vista. The service approach with th=
e=20
> elevation pipe solves exactly that problem.
>
> Openvpn is very complex, running is under a privileged account is a secur=
ity=20
> risk in my opinion. The elevation pipe offers a very limited and well def=
ined=20
> interface to configure needed system resources only and tries hard to all=
ow=20
> access for openvpn.exe only. If you compare what the possibilities of an=
=20
> attacker would be if the openvpn.exe process is compromised in both scena=
rios=20
> there's not much room to argue IMO.
>
> Regards
> Heiko
Heiko,

Could you take a look here to verify I'm describing your approach correctly:

<https://community.openvpn.net/openvpn/wiki/PrivilegeSeparation#Interactive=
service>

Also, if anyone has anything to add to the interactive service "Details
for successful implementation" section, please do so. Things along the
lines "this needs to be taken care of, or all hell breaks loose". As
James says, we need to be very careful to avoid privilege escalation bugs.

I'll also try to get James to explain his GUI/service separation
approach in more detail, maybe in an IRC meeting...

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


