Message-ID: <4F734AB5.9010609@...1114...>
Date: Wed, 28 Mar 2012 19:30:29 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F6D06C5.3030408@...1114...>
	<1332575918-3384-5-git-send-email-alon.barlev@...277...>
	<CAOazyz1VT-z7R=SXwTttVn1YrQW7Y0x=k5J+X384XZYbyNVHPA@...278...>
In-Reply-To: <CAOazyz1VT-z7R=SXwTttVn1YrQW7Y0x=k5J+X384XZYbyNVHPA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 4/6] build: msvc: upgrade to Visual
 Studio 2010 + fixups
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
Cc: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/03/12 17:07, Alon Bar-Lev wrote:
> On Sat, Mar 24, 2012 at 9:58 AM, Alon Bar-Lev <alon.barlev@...277...>
> wrote:
>> 
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- .gitignore
>> |    2 + build/msvc/msvc-generate/Makefile.am           |    2 +- 
>> build/msvc/msvc-generate/msvc-generate.vcproj  |   74 --- 
>> build/msvc/msvc-generate/msvc-generate.vcxproj |   69 +++ 
>> msvc-build.bat                                 |   27 +- 
>> msvc-dev.bat                                   |   19 +- 
>> msvc-env.bat                                   |    7 +- openvpn.sln
>> |   90 ++-- src/compat/Makefile.am                         |    3
>> +- src/compat/compat.vcproj                       |  197 ------ 
>> src/compat/compat.vcxproj                      |   87 +++ 
>> src/compat/compat.vcxproj.filters              |   42 ++ 
>> src/openvpn/Makefile.am                        |    3 +- 
>> src/openvpn/openvpn.vcproj                     |  777 
>> ------------------------ src/openvpn/openvpn.vcxproj
>> |  261 ++++++++ src/openvpn/openvpn.vcxproj.filters            |
>> 458 ++++++++++++++ src/openvpnserv/Makefile.am                    |
>> 3 +- src/openvpnserv/openvpnserv.vcproj             |  209 ------- 
>> src/openvpnserv/openvpnserv.vcxproj            |  112 ++++ 
>> src/openvpnserv/openvpnserv.vcxproj.filters    |   35 ++ 20 files
>> changed, 1153 insertions(+), 1324 deletions(-) delete mode 100644
>> build/msvc/msvc-generate/msvc-generate.vcproj create mode 100644
>> build/msvc/msvc-generate/msvc-generate.vcxproj delete mode 100644
>> src/compat/compat.vcproj create mode 100644
>> src/compat/compat.vcxproj create mode 100644
>> src/compat/compat.vcxproj.filters delete mode 100644
>> src/openvpn/openvpn.vcproj create mode 100644
>> src/openvpn/openvpn.vcxproj create mode 100644
>> src/openvpn/openvpn.vcxproj.filters delete mode 100644
>> src/openvpnserv/openvpnserv.vcproj create mode 100644
>> src/openvpnserv/openvpnserv.vcxproj create mode 100644
>> src/openvpnserv/openvpnserv.vcxproj.filters
> 
> 
> David, What with this one? No point in supporting visual studio 2008
> at 2012....

I don't have access to Visual Studio environments, so I'd rather see
someone else ack this patch.  But unless it doesn't get any NACKs within
the next week, I'll pull it using the lazy-consensus
approach.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9zSrIACgkQDC186MBRfrrAjQCgkUjV2GUgso6PZPZMDaY3N0rl
ONcAnixWsChRoFOjW/qkXpu1pnnQ2y2p
=FdA0
-----END PGP SIGNATURE-----

