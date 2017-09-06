From: David Sommerseth <davids@...515...>
Date: Thu,  7 Sep 2017 01:12:48 +0200
Message-Id: <20170906231248.23944-1-davids@...515...>
In-Reply-To: <20170822114715.14225-1-davids@...515...>
References: <20170822114715.14225-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] docs: Replace all PolarSSL
 references to mbed TLS
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
To: davids@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Thanks for the ACK.

I did a quick on-the-fly update on top of this, to ensure our buildbots
and Make in general wouldn't explode or complain.  Makefile.am still
referenced README.polarssl instead of README.mbedtls, so this is the
only additional change.  It now passes 'make distcheck'.

Your patch has been applied to the following branches

commit ed0e79938e801ec656d70cf02bcea4cdd0b79532  (master)
commit 1bea2dc0f89af74281d30e1f27dea6c434ff0c5e  (release/2.4)
Author: David Sommerseth
Date:   Tue Aug 22 13:47:15 2017 +0200

     docs: Replace all PolarSSL references to mbed TLS

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20170822114715.14225-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15309.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsIDmAAoJEIbPlEyWcf3yoEUQAMCybv8ahJinXwQuT61c7iBl
duAKO1vmdjoMmDT4OFVzicRJnNizHo3TGxdqyqJgG7nk0UK9EZ6y7TRc9OSPr2Px
4JFfdMhsA2W87WMO21mu/g5PSDWd+zZ8XIFEr72RJQEAWxO+eXT2HoGOMOH/Um5O
OeeFnbUge4z+nZQfni8vL4mmpdgE1HtxcFlYJxhv7DEOyqyc+lApjLn5nPf3+h7m
4lgx1VBy4/WSR0J7I9xoT/EVxH4YXL63hj6vZxT8Y2PSWXDvRT7jfnM5ZJ7DknMQ
h6ExsmscjW/h0W+CTwgxsQeVkvk4SzeK8lO1l5DlkkB2R2apnm+vkW+1T0cdgzbw
wqjPOK8+yaTSOShmXAmNFLudGasJ3eKcy4oldHiD+nbmZX+fMuVWjXzE18HJluje
K8OqPpdiB5hbRSnJ3xQLdLZVSIaiTsSjgsQ4svEr4yPvP+HUWQN27ncF/9yi6RA2
ly4g8e1UxOE+me8FRUzqosLzWmM7/7S8/zA6lciG9HJLqWYeF2YBrA1bddIcTc5f
GVkmplJ2WZ+LgAelFhwJlwNClPQhesOP3f7/c6oUL3qVKkuSJX5jgCuph800LF5d
c+KCd0KBCQJcGmJGgXtriqfcdQcAZU42XP/4Nxa/hd5FX5SJjXsyeH6hgI9KQv1Z
nMgz5+IfqUcSh8GYWdM9
=4/RZ
-----END PGP SIGNATURE-----

