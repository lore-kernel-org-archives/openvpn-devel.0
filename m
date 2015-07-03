Message-ID: <55963A07.8010504@...515...>
Date: Fri, 03 Jul 2015 10:30:15 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <55950ACC.1000909@...1147...>
In-Reply-To: <55950ACC.1000909@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Add TFTP and WPAD DHCP options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Attached is the patch to add the TFTP and WPAD DHCP options. The patch
> is based on openvpn 2.3.7 as I did not know how to do a windows mingw
> build of the git version ...
One way to build a git version on openvpn-build is this:

$ git clone <url>
$ mv openvpn openvpn-2.3_git
$ cd openvpn
$ autoreconf -vi
$ cd ..
$ tar -zcf openvpn-2.3_git.tar.gz openvpn-2.3_git

Then copy openvpn-2.3_git.tar.gz to a webserver and set openvpn version 
to "2.3_git" in generic/build.vars. Renaming the directory is needed due 
to how openvpn-build moves around in the build directories.

Samuli

