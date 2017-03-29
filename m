From: David Sommerseth <davids@...515...>
Date: Wed, 29 Mar 2017 12:41:42 +0200
Message-Id: <20170329104142.26314-1-davids@...515...>
In-Reply-To: <20170328205346.18844-1-davids@...515...>
References: <20170328205346.18844-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] auth-token: Ensure tokens are
	always wiped on de-auth
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
To: davids@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

The embarrassing mistakes in the v2 patch to the ML was corrected
on the fly.

Your patch has been applied to the following branches

commit daab0a9fa8ff4f40e8a34707db0ac156d49fbfcb  (master)
commit 79b93b6e421637fcd3de5cebd08d28fdfc6bdc1e  (release/2.4)
Author: David Sommerseth
Date:   Tue Mar 28 22:53:46 2017 +0200

     auth-token: Ensure tokens are always wiped on de-auth

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Steffan Karger <steffan@...1856...>
     Message-Id: <20170328205346.18844-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14344.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY249fAAoJEIbPlEyWcf3yQF8P/RHHvrJ7dyxPdHnDj3nVTZRA
QroQ/nbs8a3BNd17zqoxlRbdbYGb+P2zbSk+cPge9JqANAV1u++SUfsATjwnASer
pCQ6JtETGmbyqBC4lhmvJrtc+t/4U2LcenEEWLtTTWLEO89QoFGzzLQUgS5N/MOz
YHT11k0+P5Tcwf/DexQViqJwM3LRIIkZXnSV6xeBiIl0YeEKSht+14bUMhkqYnw9
SLNNBRDT8RweHpcZhsi6Gj2GAo+yRyXTXtniSp1A+N36QzngsbPEODVbH6RQ10Fl
r0CFcTqmj46hGJ4Q9ofkXNry0W5f/Zq0hxuiVonZmYbdev20zYIRab9m/8yi2zMn
PDJQ2fvPEHqmCHI+7BCd7RTZWyWMnSYD2SjpLXUHZmjvaMMZp8v9VPLJaKdD3GJN
M7f++wb34Ho/eVSjqlcmuIddw8ttQeyUUI0btpwZ03DuUHpALZKNkUUcnJPqA7nO
OFLym/dutUcImM/8S9AYRJ6ymDY+RIpZOsNZ9gy/eVND6oE9GfiTREwc7JYE+Z6Q
yTlExnng61KMtfMusYPz1HR0epKhCkzIIlWuQZGDkgNTyYzlqD2rUsQMMflhfkZ2
T/9G5hrgfKmGbOvZVBnBSmbSsuzqg6A2Ksz6H1Qwz2UvinF3Aquds1REAES2TCYP
IElHZ1Fee6ho5MOLQiZb
=mj0h
-----END PGP SIGNATURE-----

