Message-ID: <4B97D385.3010506@...1114...>
Date: Wed, 10 Mar 2010 18:14:45 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1268218182-21015-1-git-send-email-openvpn.list@...1114...>	
	<4B978D0E.9090606@...1114...>	
	<9e0cf0bf1003100842r408389c7occa7dcf0d27ad59a@...278...>	
	<4B97CDF3.6060703@...1114...>
	<9e0cf0bf1003100903k3647ba78t40bb93d5d9a5d8d8@...278...>
In-Reply-To: <9e0cf0bf1003100903k3647ba78t40bb93d5d9a5d8d8@...278...>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/03/10 18:03, Alon Bar-Lev wrote:
> On Wed, Mar 10, 2010 at 6:50 PM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> I'm willing to accept patches with updates as long as it don't break the
>> oldest version OpenVPN need to support (autotools/autoconf v2.59).  If
>> it can be built an old RHEL4.6 installation, it's good enough for James,
>> according to the last meeting.
> 
> This is the root cause of the mistake.
> You don't have any dependency in the versions of
> autoconf/automake/libtool at target machine.
> These tools are used at the packager machine in order to generate
> whatever needed in order to successfully compile on target machine.
> So there is no need to support old versions of these tools.
> The decent versions are >=autoconf-2.60 >=automake-1.10 >=libtool-1.5.26
> 

Well, I wish it was as easy as just to update everything to decent
versions of autotools.  But the fact is that it's a requirement to be
able to build OpenVPN on RHEL4.6.  I am not in a position to move that
requirement now.

[root@...23... ~]# cat /etc/redhat-release
Red Hat Enterprise Linux AS release 4 (Nahant Update 6)
[root@...23... ~]# rpm -q autoconf automake libtool
autoconf-2.59-5
automake-1.9.2-3
libtool-1.5.6-4.EL4.2

If it really makes sense to support building on a ~2 year old RHEL4 base
installation, that's a completely different question.  But that's the
reality I need to work within right now.


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuX04IACgkQDC186MBRfrockACfai1otkAjPZZ46Pcdfd99a+VT
Z90An20IVCpEFeHGRTaKq1H5YswtUUm0
=ukuX
-----END PGP SIGNATURE-----

