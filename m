MIME-Version: 1.0
In-Reply-To: <4B97D385.3010506@...1114...>
References: <1268218182-21015-1-git-send-email-openvpn.list@...1114...>
	<4B978D0E.9090606@...1114...>
	<9e0cf0bf1003100842r408389c7occa7dcf0d27ad59a@...278...>
	<4B97CDF3.6060703@...1114...>
	<9e0cf0bf1003100903k3647ba78t40bb93d5d9a5d8d8@...278...>
	<4B97D385.3010506@...1114...>
Date: Wed, 10 Mar 2010 19:19:13 +0200
Message-ID: <9e0cf0bf1003100919l307a653er7c619b5f2fc97dc@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE if
	not defined
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
Cc: openvpn-devel@lists.sourceforge.net

I will try to explain again.

You have two roles of environments:

1. Developer/packager workstation.

2. Target environment.

For example, 1 would be my computer, and 2 would be the old redhat computer.

You go to (1) and do:
$ autoreconf -ivf
$ ./configure && make dist

Now, you transfer the tarball to users, the old redhat computer is one
of them. The tarball will work WITHOUT ANY AUTOCONF/AUTOMAKE/LIBTOOL
installed.

I use older environments as (2) such as solaris-8.

If you don't believe me try it out.

Alon.

On Wed, Mar 10, 2010 at 7:14 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 10/03/10 18:03, Alon Bar-Lev wrote:
>> On Wed, Mar 10, 2010 at 6:50 PM, David Sommerseth
>> <openvpn.list@...1114...> wrote:
>>> I'm willing to accept patches with updates as long as it don't break the
>>> oldest version OpenVPN need to support (autotools/autoconf v2.59). =C2=
=A0If
>>> it can be built an old RHEL4.6 installation, it's good enough for James,
>>> according to the last meeting.
>>
>> This is the root cause of the mistake.
>> You don't have any dependency in the versions of
>> autoconf/automake/libtool at target machine.
>> These tools are used at the packager machine in order to generate
>> whatever needed in order to successfully compile on target machine.
>> So there is no need to support old versions of these tools.
>> The decent versions are >=3Dautoconf-2.60 >=3Dautomake-1.10 >=3Dlibtool-=
1.5.26
>>
>
> Well, I wish it was as easy as just to update everything to decent
> versions of autotools. =C2=A0But the fact is that it's a requirement to be
> able to build OpenVPN on RHEL4.6. =C2=A0I am not in a position to move th=
at
> requirement now.
>
> [root@...23... ~]# cat /etc/redhat-release
> Red Hat Enterprise Linux AS release 4 (Nahant Update 6)
> [root@...23... ~]# rpm -q autoconf automake libtool
> autoconf-2.59-5
> automake-1.9.2-3
> libtool-1.5.6-4.EL4.2
>
> If it really makes sense to support building on a ~2 year old RHEL4 base
> installation, that's a completely different question. =C2=A0But that's the
> reality I need to work within right now.
>
>
> kind regards,
>
> David Sommerseth
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkuX04IACgkQDC186MBRfrockACfai1otkAjPZZ46Pcdfd99a+VT
> Z90An20IVCpEFeHGRTaKq1H5YswtUUm0
> =3DukuX
> -----END PGP SIGNATURE-----
>

