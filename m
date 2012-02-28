Message-ID: <4F4D232A.5040205@...1114...>
Date: Tue, 28 Feb 2012 19:55:38 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
	<1111951883.20120228191750@...449...>
	<4F4D1D5F.2090208@...1114...>
	<CAOazyz2KBtP8onxNjRxeqsYyeyTyDOqwOpVvKWw8nn6My4n=1A@...278...>
In-Reply-To: <CAOazyz2KBtP8onxNjRxeqsYyeyTyDOqwOpVvKWw8nn6My4n=1A@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: =?UTF-8?B?Q2Fyc3RlbiBLcsO8Z2Vy?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/12 19:42, Alon Bar-Lev wrote:
> 2012/2/28 David Sommerseth <openvpn.list@...1114...>:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>=20
>> On 28/02/12 19:17, Carsten Kr=C3=BCger wrote:
>>> Hello Alon,
>>>=20
>>> ABL> This is *THE* missing functionality in Windows environment.
>>> ABL> It seems that nobody interested in developing proper UI using
>>> ABL> management interface for Windows. ABL> Same goes to proper
>>> smartcard support.
>>>=20
>>> Developing the UI (command line) would be trivial but to my
>>> knowledge (I'm reading the mailinglist for last 7 years) there is
>>> no management interface in openvpn that would allow this.
>>>=20
>>=20
>> Have you seen this document?  (management/management-notes.txt)=20
>> <http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-t=
esting.git;a=3Dblob_plain;f=3Dmanagement/management-notes.txt;hb=3Dmaster>
>>
>>
>>=20
Especially look for all the 'pkcs11' prefixed calls, like
>> pkcs11-id-count, pkcs11-id-get.  Further James implemented a new
>> feature for the management interface where you can pass the
>> certificate this way too.  Unfortunately, as Alon pointed out, this
>> has not yet been documented well - except in the commit log.
>=20
> These features are mine. I wrote these.... and the whole PKCS#11
> layer, and many other... like the ability to wrap the iproute2. They
> are good, but not great. Why? Because the openvpn daemon it-self loads
> the PKCS#11 provider. This is a security violation. The PKCS#11
> provider should be loaded by the UI, so the daemon cannot interact
> with it at will.

Agreed!  And I remember this was part of the discussions at FOSDEM.  How
should the GUI communicate in regards to the PKCS#11 layer, and how to
provide the proper information towards the core OpenVPN process.  We were
not aware of the --management-external-key at that point, but I think
this is the natural way to look now.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9NIykACgkQDC186MBRfrqdvQCgpOTCxegtLzCPaQ6eOnxfuCOA
v58AnA2d/xD1/zhXZRj/SWqplv/t//mV
=3DcDMr
-----END PGP SIGNATURE-----

