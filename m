References: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>
	<bfb1203d-06e7-8242-c4bd-091e7d50801f@...2080...>
	<1a69f080-a1bc-f646-ffdc-5c5ca27ac1f4@...277...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <6ec92ca3-7050-6e6e-533e-4771e4970816@...515...>
Date: Mon, 29 May 2017 08:57:08 +0300
MIME-Version: 1.0
In-Reply-To: <1a69f080-a1bc-f646-ffdc-5c5ca27ac1f4@...277...>
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
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

On 29/05/2017 00:36, debbie10t wrote:
>=20
>=20
> On 28/05/17 22:09, David Sommerseth wrote:
>> On 28/05/17 22:47, debbie10t wrote:
>>> Hi
>>>
>>> This is just a heads up !
>>>
>>> I cannot build openvpn on ubuntu 16.04.2 LTS (fresh install) because
>>> ./configure --enable-systemd fails to build with the following error:
>>>
>> [...snip...]
>>> checking for libsystemd... no
>>> checking for libsystemd... no
>>> configure: error: in `/home/dik/openvpn/master':
>>> configure: error: The pkg-config script could not be found or is too
>>> old.  Make sure it
>>> is in your PATH or set the PKG_CONFIG environment variable to the full
>>> path to pkg-config.
>>>
>> [...snip...]
>>>
>>> $ systemctl version
>>> Unknown operation version.
>>
>> Can you try --version instead of just 'version'?
>=20
> oops ..
>=20
> $ systemctl --version
> systemd 229
> +PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP
> +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS
> +KMOD -IDN
>=20
>=20
> sorry about that blunder
>=20
>=20
>>
>>> apt-get install libsystemd-dev is done
>>
>> Can you locate libsystemd.pc or systemd.pc on your system?  Are there
>> other systemd related -dev packages available?
>>
>>
>=20
> still looking ..
>=20
> TYVM
>=20

Try this (I ran this on Debian 8):

$ sudo -s
$ find / -name "libsystemd.pc"
/usr/lib/x86_64-linux-gnu/pkgconfig/libsystemd.pc
$ find / -name "systemd.pc"
/usr/share/pkgconfig/systemd.pc

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

