Message-ID: <542AD20E.1010809@...515...>
Date: Tue, 30 Sep 2014 18:53:50 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <54291DD9.6060802@...515...> <54297B80.8010902@...1147...>	
	<542A6728.6000707@...515...>
	<20140930114153.GZ396@...1296...>	
	<542A9F92.7060908@...515...>
	<1412080148.7178.15.camel@...1866...>
In-Reply-To: <1412080148.7178.15.camel@...1866...>
Subject: Re: [Openvpn-devel] Any Windows-based OpenVPN servers available for
 fixing bug #432?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: David Woodhouse <dwmw2@...1866...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> On Tue, 2014-09-30 at 15:18 +0300, Samuli Sepp=C3=A4nen wrote:
>>> Hi,
>>>
>>> On Tue, Sep 30, 2014 at 11:17:44AM +0300, Samuli Sepp=C3=A4nen wrote:
>>>> Just got more info from Thomas who's fixing the tap-windows6 issues.
>>>> According to him most of the bugs are actually triggered by user-space
>>>> code in OpenVPN 2.x which does not handle tap-windows errors correctly.
>>>> He's working on that issue right now.
>>>
>>> Patches for the 2.x code welcome :-)  - I have no idea what we do wrong,
>>> as the whole "talk to a windows device driver" thing is magic for me.
>>>
>>> gert
>>
>> Apparently 2.x is not handling certain tap-windows6 return/error codes
>> correctly. According to Thomas that is causing several of the issues
>> we've experienced with tap-windows6.
>
> Do you have specifics, or should I wait for patches to land? I'll check
> for similar problems in OpenConnect.
>

Quoting Thomas:

"Incorrect handling error 995 in user-mode service is cause of _several_
of the remaining errors."

- --=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQq0g4ACgkQwp2X7RmNIqOvWgCeKfUmF4swyG+naGR2+jLI02hU
FR0AoJ77qs84Tuhj0RzD6WvbBjzQpWWf
=3D6Nfw
-----END PGP SIGNATURE-----


