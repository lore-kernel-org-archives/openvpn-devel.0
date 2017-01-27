From: David Sommerseth <davids@...515...>
Date: Fri, 27 Jan 2017 15:50:02 +0100
Message-Id: <20170127145002.13864-1-davids@...515...>
In-Reply-To: <20170127084927.21040-1-list@...1798...>
References: <20170127084927.21040-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH applied] plugin: Remove GNUism in
	openvpn-plugin.h generation
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
To: mail@...1798...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I reworded the commit message slightly, as this isn't strictly
bound to out-of-tree builds (which the original commit message
stated), but related to GNU extensions in the Makefile which fails
on non-GNU Make.

Your patch has been applied to the following branches

commit 631812fe29c69d0034628ab8321cb4016cb4fc2d  (master)
commit cb17255b1f7600b3255d1e018cfc426b40da4044  (release/2.4)
Author: Christian Hesse
Date:   Fri Jan 27 09:49:27 2017 +0100

     plugin: Remove GNUism in openvpn-plugin.h generation

     Signed-off-by: Christian Hesse <mail@...1798...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170127084927.21040-1-list@...1798...>
     URL: http://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13966.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYi14UAAoJEIbPlEyWcf3y/ccP/j6RXkfFqxHC6aG19WyVPu9g
91N9RvrVFfDQZ6QULWkLzL98At+x35P+iOjs6qQRKWmnKv+U4LGjJbdS+t1AzABM
Yhbovsa+0jcs+SfE1Du8asODt/5222aNtqjRO04edq3BBNoMi4u3AnxJ2ExyGXGF
QCQ/ZpWaRu9eBCUZU3/9Cf9G8aMTg2xKGlswdvkUjvyEkj5x+YwVCM+htFYshEWD
JFIVeVPfgBh60Sv6kpBP8C+2LrdMsY/n7s3EoCH+riwDO/J5ZrfNmUFrWRZ86V7M
EomUn8DF2FOVKBfu59O2Ka4X9oLlHdik+YGjCbnRiSTIT1eezdUXgIzUpwBwg7eb
klwPtkeDnNR0XUeuyqaXxC1THuQHi7qJQTcdbKTBBuabtIoAfBT3H2COC8dJOmMU
MY1Ih5uf8K/kfG9AZMxfFr3IEt+yo/c+iEIg9sHZwfQNXDXnRH3zyyPApe1H5Sgi
9ubh7lK9+5gv+DJY8XNKS42xZYiVaHFb820dh8MMkhJ/j1Vzgcst7HiKo24ntxsa
/nx0fyArFa5anYy3hoD36iOmDiZwnC0J1SkzgXqLCpXnO19kP96GBymFBHXrGF59
SrZOllkAeoldrsvp94ArLdMFQe4NSUS+KrPo+ACqAISxndNPUaQsHSSjYmptermN
JnNGw9dRuxhuU83DwPko
=/dLr
-----END PGP SIGNATURE-----

