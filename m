Reply-To: openvpn-devel@lists.sourceforge.net
References: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>
	<bfb1203d-06e7-8242-c4bd-091e7d50801f@...2080...>
	<1a69f080-a1bc-f646-ffdc-5c5ca27ac1f4@...277...>
	<6ec92ca3-7050-6e6e-533e-4771e4970816@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ec48fefc-8b36-d34c-9ddb-18f196eabd8e@...2080...>
Date: Mon, 29 May 2017 10:47:36 +0200
MIME-Version: 1.0
In-Reply-To: <6ec92ca3-7050-6e6e-533e-4771e4970816@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BWEkV5obx4FlBwUAUHc58oMeA1pujWESe"
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
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BWEkV5obx4FlBwUAUHc58oMeA1pujWESe
Content-Type: multipart/mixed; boundary="P70b1b9CFiOk9fK48TdNarkRxkAAaIrqR";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
 debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <ec48fefc-8b36-d34c-9ddb-18f196eabd8e@...2080...>
Subject: Re: [Openvpn-devel] Ubuntu 16.04.2 LTS --enable-systemd ./configure
 error
References: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>
 <bfb1203d-06e7-8242-c4bd-091e7d50801f@...2080...>
 <1a69f080-a1bc-f646-ffdc-5c5ca27ac1f4@...277...>
 <6ec92ca3-7050-6e6e-533e-4771e4970816@...515...>
In-Reply-To: <6ec92ca3-7050-6e6e-533e-4771e4970816@...515...>

--P70b1b9CFiOk9fK48TdNarkRxkAAaIrqR
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 29/05/17 07:57, Samuli Sepp=C3=A4nen wrote:
> On 29/05/2017 00:36, debbie10t wrote:
[...snip...]
>>
>> $ systemctl --version
>> systemd 229
>> +PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP
>> +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS
>> +KMOD -IDN

This looks reasonable.

>>>> apt-get install libsystemd-dev is done
>>>
>>> Can you locate libsystemd.pc or systemd.pc on your system?  Are there
>>> other systemd related -dev packages available?
>>>
>>>
>>
>> still looking ..
>>
>> TYVM
>>
>=20
> Try this (I ran this on Debian 8):
>=20
> $ sudo -s
> $ find / -name "libsystemd.pc"
> /usr/lib/x86_64-linux-gnu/pkgconfig/libsystemd.pc
> $ find / -name "systemd.pc"
> /usr/share/pkgconfig/systemd.pc

Samuli:  Which systemd related -dev packages do you have installed?

debbie10t: can you also try to run:

  $ pkg-config --libs --cflags --modversion libsystemd

and

  $ pkg-config --libs --cflags --modversion systemd

The latter one might not return much more than just "229".


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--P70b1b9CFiOk9fK48TdNarkRxkAAaIrqR--

--BWEkV5obx4FlBwUAUHc58oMeA1pujWESe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZK+AwAAoJEIbPlEyWcf3y+WAP/R5nKC6ytXdubL2Tv7hg4kV9
mHkG3LuWBLeu3CG0lplK+32mlkh4lb9TFMjhKGWpjFbCO4iBacJu9Emu5y60bKtg
vTY6bFp/ZTad4HJ3ker4XDFsqrpKZrbNdftQKH8k8nDKkf1cq1iCr2YwVpHLYtT8
1D1XM0F6KCNpqWNHViHfR4ZFjUicFJaDjT7jnd9bvSaz00N+9JOs6AmMeAviSISX
aScCOnyl9YUPLUp9TILw00GeiXvcnfBp7l/2Rer8EKUZwUShWSRUtlLctx5oVk3b
7AXt/ArrYuQF1/7zuSDb2sw2/uI9s8VHYHMLG5Q3G8HAZXX0OW2r723Eef7O59li
DYdCu/le4tRrMT0sDXrxEjYTvVqkGFm/sVnwdhw6Uhkb1bOnDlJdkILqLk/uydmu
mrjyy6J/Y9fbKHFfy4IvgVRMpdS9YduikXN/XhH0vVWyFSfF3iwtKj8XGEqPY5DM
mgftuQTCUNPY+QrjWvo1UNjmdPAiEOGQouru477lGcnq0137OFNTxfSMdemANreQ
qVhHJL0Oj0T90gRheJLwaAjrZMCoHfXxG9XpRMFgqaD2xF3QK0F2lYMJOi/DmnIZ
72nEmrpKAIpZZB49EXIbje7YuY9P7Py7rJgTG+Rpk87Oi2ed3wBcK3VZEDbqSqX9
uAf81Q+I/yn/CXI6OtHx
=b/pF
-----END PGP SIGNATURE-----

--BWEkV5obx4FlBwUAUHc58oMeA1pujWESe--

