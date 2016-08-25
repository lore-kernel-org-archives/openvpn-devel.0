From: David Sommerseth <davids@...515...>
Date: Thu, 25 Aug 2016 21:15:22 +0200
Message-Id: <1472152522-22431-1-git-send-email-davids@...515...>
In-Reply-To: <1456993146-63968-10-git-send-email-james@...515...>
References: <1456993146-63968-10-git-send-email-james@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] Bind to local socket before
	dropping privileges
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
To: james@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


ACK.  Tested both master and release/2.3 branches with and without this
patch.  On master this patch was needed to allow --lport 443 together
with --user openvpn --group openvpn.  On release/2.3 this patch was
not needed.

Your patch has been applied to the master branch

commit b3e975824ea9ebae8dbea5b451c8d02525c83ffe
Author: James Yonan
Date:   Thu Mar 3 01:19:06 2016 -0700

     Bind to local socket before dropping privileges

     Signed-off-by: James Yonan <james@...515...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: 1456993146-63968-10-git-send-email-james@...515...
     URL: http://www.mail-archive.com/search?l=mid&q=1456993146-63968-10-git-send-email-james@...515...
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXv0O7AAoJEIbPlEyWcf3yZLAQAMYxU27vByo6r73VlbSPm+aJ
ycUd3OHSgLEgofRtmmXVJQv9IV5iAQnv5WYY5yiWTbJ2lEYWW5j6hxs06Lq6gdZM
MxsBq4/xrFHJxEwq8mfjjxJt3dEz+XX+UwNr3uz69vSDqK3xq7waomdMnd7lAe0M
hdqSMwyEcCoyIr5OQo2erlJuku6H8qSjDANb1MzPIB4RPLzW99UuwSMzS/WjhVvZ
m+l4LU3/fYkKiGue2r4DKHDFoc1cFPHBLA4rSCmnf2YGj8X2XHuV3cgZacmbt2VI
ygYIDtcnkvmVNXKgCPx1I+R/uyiy58auDXwEIK3fdSWP9ppi5vI9UeXf6yG8En7m
XMMUtoOBRSCH8H29fVRwgkq9H84eyMiBIsDNDda6OS9J3q8QMswOTOyXH/TpTwj1
A5cvaX64suA8RnvDRpq0gCzo92TLkU+iL1KSctOWDClUhMW6PF8mwIY4e6CpqWUk
Z8v4tBTo8xva4zCarhjLm0Xefd68sAaqppJImTSj32Ae0VzGbLRqeuKZ50uBPgDZ
MW7KuNCTV3ji6FbdJnLiynvIQdYkJLDyP5H7vbeaW5RIaC6gDdhSVUBkynSJOqGZ
MQW8uaQuPbl5GdPRmvsLcyupZhwnYhsmQ2oxn0pUKC0uFqErhhBQlst4/nBWDHDI
51Xvwwb6b+IyzvgWB+jX
=aaSH
-----END PGP SIGNATURE-----

