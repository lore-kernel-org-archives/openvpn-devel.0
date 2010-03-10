Message-ID: <4B97DCEC.9020108@...1114...>
Date: Wed, 10 Mar 2010 18:54:52 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1268242750.8679.0@...1207...>
In-Reply-To: <1268242750.8679.0@...1207...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "Karl O. Pinc" <kop@...1206...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/03/10 18:39, Karl O. Pinc wrote:
> On 03/10/2010 11:19:13 AM, Alon Bar-Lev wrote:
>> I will try to explain again.
>>
>> You have two roles of environments:
>>
>> 1. Developer/packager workstation.
>>
>> 2. Target environment.
>>
>> For example, 1 would be my computer, and 2 would be the old redhat
>> computer.
>>
>> You go to (1) and do:
>> $ autoreconf -ivf
>> $ ./configure && make dist
>>
>> Now, you transfer the tarball to users, the old redhat computer is 
>> one
>> of them. The tarball will work WITHOUT ANY AUTOCONF/AUTOMAKE/LIBTOOL
>> installed.
>>
>> I use older environments as (2) such as solaris-8.
> 
> And you don't generally want to be running ./configure from within
> a rpm specfile, so the same is true of using the rpm tools:

This is not correct.  In fact, you often use the %configure macro in
%build, which does call ./configure.  The only "allowed" exception from
not calling %configure is when ./configure is not a native autotools
generated configure script.

> On machine 2 you download the tarball, the specfile, (and
> any patches the rpm maintainer wants to include in the
> packaged version) and run the rpm build tools on the
> spec file to build a binary rpm.  
> 
> Note that http://www.rpm.org/max-rpm/s1-rpm-inside-scripts.html
> says: 
> 
> "Once the %prep script has gotten everything ready for the build, the %
> build script is usually somewhat anti-climactic — normally invoking 
> make, maybe a configuration script, and little else. 

It's %build which need to do the %configure.  All patching must happen
on %prep.  But you are right, if there are applied patches which updates
some of the autotools generated files, I believe autotools need to be
run again.  Right, Alon?


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuX3OoACgkQDC186MBRfrrMpgCfa6qtBOfumt0Z2AIRP6G7Eaem
TEoAnRVqqeU2mFs8XbmiL9ry3NR6ETDJ
=IY4/
-----END PGP SIGNATURE-----

