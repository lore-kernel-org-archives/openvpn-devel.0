Message-ID: <4F09D048.5000102@...515...>
Date: Sun, 08 Jan 2012 19:20:08 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <1320075008.29689.31.camel@...1520...>
	<4EAF0EFD.6060106@...1114...>
	<1323712625.31471.4.camel@...1520...>
	<4F071FD7.3060201@...1114...>
	<1325868040.2547.19.camel@...1520...>
	<4F072D07.7060602@...1114...>
In-Reply-To: <4F072D07.7060602@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] adding support for systemd tty console
 wrapper
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>>> In get_console_input_systemd() you do:
>>>
>>> +  *input =3D 0;
>>>
>>> I think it would be better to do: CLEAR(*input) instead.  Just setting
>>> the first byte to 0, will not solve any leak possibilities.  An
>>> alternative is to use memset() directly, which the CLEAR() macro uses
>>> (see basic.h:47), but we prefer to use CLEAR() over memset() directly.
>> done (and I've also fixed some missing spaces in various location).
>>
>> See the new version attached.
> Goodie!  I presume you did some compile and sanity testing before
> submitting the patch, so that it won't bite our compile farm :)  I think =
we
> have a F15 or F16 box (which uses systemd) in the farm, so we can enable
> systemd features on that box.
I got two F16 boxes which I can use for systemd testing. I'll integrate
those with buildbot next week.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


