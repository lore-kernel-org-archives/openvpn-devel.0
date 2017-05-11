From: David Sommerseth <davids@...515...>
Date: Thu, 11 May 2017 18:43:47 +0200
Message-Id: <20170511164347.1774-1-davids@...515...>
In-Reply-To: <1494358209-4568-3-git-send-email-steffan.karger@...1435...>
References: <1494358209-4568-3-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH applied] Drop packets instead of assert
	out if packet id rolls over (CVE-2017-7479)
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
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

ACK.

Your patch has been applied to the following branches

commit e498cb0ea8d3a451b39eaf6f9b6a7488f18250b8  (master)
commit 591a4e574c43cb9e820950f15dcaabda261def78  (release/2.4)
Author: Steffan Karger
Date:   Tue May 9 21:30:09 2017 +0200

     Drop packets instead of assert out if packet id rolls over (CVE-2017-7479)

     CVE: 2017-7479
     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1494358209-4568-3-git-send-email-steffan.karger@...1435...>
     URL: http://www.mail-archive.com/search?l=mid&q=1494358209-4568-3-git-send-email-steffan.karger@...1435...
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZFJS+AAoJEIbPlEyWcf3yeowP/3sXzeF+eISWsJBuXdmQMsW6
PGXZcdW6VQFDurVnFn0fzqa8L6D+vkdqgpV/y1b/FuyLkI3ChhWAL94DCnzpyHR1
XnU0KWWY9OaYIfhxG0FGxoSAIvD3ZZhExlixgkitHaUQYWbT55ksUIQXTAJTGgBp
PvfGKSLKYrd61USIBtsswa/G28U/F+VfVjNNDK+3qHcALgDH0o+gQSls+4Mp1Nzv
OURGMqHHRPvz9Omr6uDi58dgyByUKa9VTd+l/ogUvw13nfXnHFZv+SPPidz9DU1W
c9Im/2XZGFbIaQSujsF06lAG4rBLSEt6DZaSrO9pIQEsJkXZb6GDZ5434HVjRnBT
CTH2r+/mcIPOpF4514gI34ncksIDJUCxWmZXxFdB8krGU8FXi7WTYr2RLvChVKvv
ukbFfWRJqOHUKYvVho5aGTEqRV4M37XFpttg9GmDjSBNNTCOJJIIiKGNjOww5Gle
XnavipQ0MlOy0fSEreXZKMPrfEiHnsNTLbgd4GvdOe4p6mHrzCb62DRqVEhckskL
SjGuVNnVxkn76QVUoz9u2mclYk5zJb9lE/1lpkYhEBf0vzKESO3Um8KDxPFXoQil
JYkvu4kqTjPnt0XhOlpMCw1kViCpIqrZ8uDqyywu2srpGKawk7idqfSUq9Jbuwjv
UTJBgCspAV4ca2NoAP06
=CDxG
-----END PGP SIGNATURE-----

