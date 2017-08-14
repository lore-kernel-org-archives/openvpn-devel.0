From: David Sommerseth <davids@...515...>
Date: Mon, 14 Aug 2017 15:55:10 +0200
Message-Id: <20170814135510.21436-1-davids@...515...>
In-Reply-To: <20170802181435.14549-2-ch@...2291...>
References: <20170802181435.14549-2-ch@...2291...>
Subject: Re: [Openvpn-devel] [PATCH applied] Use provided env vars in
 up/down script.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ch@...2291...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

ACK.  Verified that ${dev} does indeed exists in --up and when the plug-in
runs with OPENVPN_PLUGIN_DOWN mode, which is facilitated via the down-root
plug-in.

Your patch has been applied to the following branches

commit 94c1ce22ebcc1f672bb80598afccc130aa01fafc  (master)
commit 9f390f0209aa119f7625a75ae309787bc6785831  (release/2.4)
Author: Conrad Hoffmann
Date:   Wed Aug 2 20:14:34 2017 +0200

     Use provided env vars in up/down script.

     Signed-off-by: Conrad Hoffmann <ch@...2291...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20170802181435.14549-2-ch@...2291...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15165.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZkau8AAoJEIbPlEyWcf3yxFwP/jdgEw7U5naNlSTSOmDnOE32
ox/JMuKEeWx4U4j+ngsijBGciX+kaEWihPCFfYgTnZw25aR2vQfz5eGeDpdNrf7h
Sk/sddAjy1urIn97aA2gdbNOt2JXjuPYXPbTMvbp/HAby3rjdsP+WwftRS5PlNfC
wh85felObSHULdw/9keLZMVYgrkNWKB1FdAsKxXW0ky5bj3qTYL5BNPtqPe0Iw6D
iSi3XeUwRYDQ0tegzoIJYaEIzEfCSiTpr64mOvotVvmNDDg5y5QkMJg9UtXrkBsC
xFd7CIOjBArht44U7OM0tK1KNEqa5W7n3EFUu10hsuEUVI5VAQwPLppTt9Zf7ja2
X0MhMBD7+Eh3lOX+SKjuOfO+lKhNtM3f0T3Nklrz7zxhNlMinn3a4w9xgDMHrsj2
vhBuQfRtvsnQEY41egibEL0dNRvwVSDdGziFtgRBc75qUihFD+yVbLdYxz1lQ9RP
jmWKJn6QS6U4at88z0h+gYM2XYLXTbNzAn49C78HQZbTw2gSlpUcrVEEF554FPSt
zWQ47p5sUbUDptS1pPrCPsh+s03drWYOYqVY6O2NHz4Qz+vgd//eXW2pKMf90l2E
wuPxbA7wIzUGhwGWFzGyf/u7v9zqJnj9a7hOS7Poka90tSiMCsw1iIkLPsR5Lu2d
yyhWjWqhpKLTr1rpc3dq
=dG9l
-----END PGP SIGNATURE-----

