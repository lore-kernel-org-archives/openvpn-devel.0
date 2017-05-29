References: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>
	<bfb1203d-06e7-8242-c4bd-091e7d50801f@...2080...>
	<1a69f080-a1bc-f646-ffdc-5c5ca27ac1f4@...277...>
	<6ec92ca3-7050-6e6e-533e-4771e4970816@...515...>
	<ec48fefc-8b36-d34c-9ddb-18f196eabd8e@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <3596d078-0da3-4320-8a59-dcd51c772655@...515...>
Date: Mon, 29 May 2017 13:37:51 +0300
MIME-Version: 1.0
In-Reply-To: <ec48fefc-8b36-d34c-9ddb-18f196eabd8e@...2080...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Ubuntu 16.04.2 LTS --enable-systemd ./configure
 error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, debbie10t <debbie10t@...277...>

Hi,

On 29/05/2017 11:47, David Sommerseth wrote:
> On 29/05/17 07:57, Samuli Sepp=C3=A4nen wrote:
>> On 29/05/2017 00:36, debbie10t wrote:
> [...snip...]
>>>
>>> $ systemctl --version
>>> systemd 229
>>> +PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP
>>> +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS
>>> +KMOD -IDN
>=20
> This looks reasonable.
>=20
>>>>> apt-get install libsystemd-dev is done
>>>>
>>>> Can you locate libsystemd.pc or systemd.pc on your system?  Are there
>>>> other systemd related -dev packages available?
>>>>
>>>>
>>>
>>> still looking ..
>>>
>>> TYVM
>>>
>>
>> Try this (I ran this on Debian 8):
>>
>> $ sudo -s
>> $ find / -name "libsystemd.pc"
>> /usr/lib/x86_64-linux-gnu/pkgconfig/libsystemd.pc
>> $ find / -name "systemd.pc"
>> /usr/share/pkgconfig/systemd.pc
>=20
> Samuli:  Which systemd related -dev packages do you have installed?

libsystemd-daemon-dev
libsystemd-dev

>=20
> debbie10t: can you also try to run:
>=20
>   $ pkg-config --libs --cflags --modversion libsystemd
>=20
> and
>=20
>   $ pkg-config --libs --cflags --modversion systemd
>=20
> The latter one might not return much more than just "229".
>=20
>=20

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

