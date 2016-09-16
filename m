From: David Sommerseth <davids@...515...>
Date: Fri, 16 Sep 2016 18:39:13 +0200
Message-Id: <1474043953-1955-1-git-send-email-davids@...515...>
In-Reply-To: <1474040436-9855-1-git-send-email-steffan@...1856...>
References: <1474040436-9855-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Make gnu89 support explicit
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
To: steffan@...1856...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


ACK.  This works well on CentOS 5, so this change makes sense as this
makes the compiler behaviour more predictable in regards to C standards.

This will most possibly break non-GNU compilers though (Solaris and AIX?).
But as this behaviour can be overridden by setting the CFLAGS to a -std
those compilers accepts, I consider this reasonable.  The recommended
way to set CFLAGS is like this:

     ./configure CFLAGS="-std=c99"

This ensures that if configure decides it is needed to do a re-configure
run, it will preserve the CFLAGS setting.


Your patch has been applied to the release/2.3 branch.

commit 130c27b1f24a33c77e01b2cf82c3427699153967
Author: Steffan Karger
Date:   Fri Sep 16 17:40:36 2016 +0200

     Make gnu89 support explicit

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: 1474040436-9855-1-git-send-email-steffan@...1856...
     URL: http://www.mail-archive.com/search?l=mid&q=1474040436-9855-1-git-send-email-steffan@...1856...
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX3CATAAoJEIbPlEyWcf3y3LoP/17RIq3BOQi+mpG1APbyaokE
e9neSJYjIDIcRMFA0daaqap3q6cXoapzeafWQ/LdJbZv5hc4pC2gYemBltqwagV+
SS7MQTCu5oqnw2E86c3T7+EjzmwnbJk0/KB+fsjH9q25OEVpOHZ9ztQ4vsn60pCr
fPoB6OmNjJqJBbgKGm2bY6U0rhl/Wkap00NhiIiSQPJY24d7jZ6ZCIeIq+muvELc
Zj325IbZsxDmsAPN309dJ3LAEZX2f13PfaLiMdNu7ZnKFUcnJBIGpXYoDWAaIuY6
G42hkHz8KP0f8y0ZNxiOwLWNCCePEmYiRLwHkW4mZSoPewSMy2hZbWcYnFWVUT96
HISpoyRGRJZQ75Vo6vee19ck4Mr+b7/JUmL6cP7UgY8TmlRRAAYeU626OYe/j+r9
9rG9ulAuFUAv0KJeqLKLzFj+3krN8eRdelzuAMcBfQPAb4n/1YAQk71KzsRIyO2T
PWOE8kGkSm2GRCZnlQPgD5lEx9p7bHKFEJylpnFCd5uiFAPfVvvz25UREU/sd7Si
x2Q5Oxq8XtJF9UEqutWieutkGYPR5/OQifFb2+sJpXN1GNoa0qbZw8CZ9EVJCywe
8O2u7GVbNFAw5vy0Ri+XQXXF3y2Vc3clVfwg0LQC1GhxylAQQboKWKksLRKVna1G
Op6mg2SglMw4wYEkLG1K
=lCei
-----END PGP SIGNATURE-----

