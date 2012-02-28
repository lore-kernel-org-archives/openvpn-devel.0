MIME-Version: 1.0
In-Reply-To: <4F4B542D.9090309@...1114...>
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz0f3sERwjZsf3Ts3Xu7CQqBEf_-_VdbUZ7TrzhLbmTEsg@...278...>
	<CAOazyz1buhSdSF7g6MzePAiQ=irD_Qo-RKPC_jXoR9AVqbtkvQ@...278...>
	<CAOBzU4P0SxY-jF7rb_HsvmtSH8i9PCk+qe5iDQiwJhajsBuYuw@...278...>
	<CAOazyz1naScdf+M0pnePS6-bb5deAHsAniTiv+DFw3ZQdAN+kg@...278...>
	<CAOazyz1DE7Y-P9HFK3LN8-HeoGbHzYeqofX3RiEuK0C-zcxnug@...278...>
	<CAOazyz0nV8P8Age_wyFCvu1J4g1MECA7YdTAAL4of7TTVctXow@...278...>
	<1CED409804E2164C8104F9E623B08B90129350BEDF@...1436...>
	<CAOazyz0daYPAH=ooKDenavTyG1qK1=wJv8ZJ0VF+u-vXWBE2xQ@...278...>
	<4F4B456A.8010208@...515...> <4F4B542D.9090309@...1114...>
Date: Tue, 28 Feb 2012 23:31:55 +0200
Message-ID: <CAOazyz1E809DFQ7-GBvopezmELL+SuW+A5A+EKgbXTsZTNVd8w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello,

I think I finished.
David, tell me if you want me to send the patches to the list.
I think these are way too long.

I will be happy if people can test this.

Modified OpenVPN repository[1], build system re-write + cleanups.
Build automation repository[2], provides cross compile, msvc and
completely re-written installer.
TAP-Windows as own repository[3], output is standalone tap installer[8].
Easy-RSA as own repository[4], output is plain tarball.
OpenVPN-GUI repository[5], build system re-write.

Installers are available[6][7], unsigned but should work.
I am interested especially in win64 installations.
The standalone tap installation[8] should be used for problem isolation
 if the embed tap installer within openvpn installer fails.

To create windows installer use:
$ git clone https://github.com/alonbl/openvpn-build
$ cd openvpn-build/windows-nsis
$ ./build-complete

Alon

[1] https://github.com/alonbl/openvpn (build)
[2] https://github.com/alonbl/openvpn-build
[3] https://github.com/alonbl/tap-windows
[4] https://github.com/alonbl/easy-rsa
[5] https://github.com/alonbl/openvpn-gui (build)
[6] https://github.com/downloads/alonbl/openvpn/openvpn-install-2.3_alpha1-I000-x86_64.exe
[7] https://github.com/downloads/alonbl/openvpn/openvpn-install-2.3_alpha1-I000-i686.exe
[8] https://github.com/downloads/alonbl/tap-windows/tap-windows-9.9.exe

