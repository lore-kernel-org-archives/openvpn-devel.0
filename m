From: David Sommerseth <davids@...515...>
Date: Fri, 22 Sep 2017 02:00:31 +0200
Message-Id: <20170922000031.6655-1-davids@...515...>
In-Reply-To: <80690690-67ac-3320-1891-9fecedc6a1fa@...1435...>
References: <80690690-67ac-3320-1891-9fecedc6a1fa@...1435...>
Subject: Re: [Openvpn-devel] [PATCH applied] Fix bounds check in read_key()
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
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Even though this fix have been backported and applied to release/2.3 and
older, we will only plan releases for v2.3 and v2.4.  We have mainly
backported this issue to release/2.3, but it was very easy to cherry-pick
this fix to the older branches; thus it was done so.

This patch is also sent out to the list a bit earlier than we normally
do , as the security impact of this issue is considered to be minimal.
This requires configurations to use --key-method 1 and will only work
in some of the many possible configuration possibilities.  When also 
considering that --key-method 2 have been the default since April 2005,
then it is hopefully clear that this is not a very critical issue.

This patch has been applied to the following branches

commit 3b1a61e9fb27213c46f76312f4065816bee8ed01  (master)
commit c7e259160b28e94e4ea7f0ef767f8134283af255  (release/2.4)
commit fce34375295151f548a26c2d0eb30141e427c81a  (release/2.3)
commit a9f5c744d6b09f2495ca48d2c926efd3a4b981e6  (release/2.2)
commit c560f95e7038daa3a1b5a08b69b85fb68d4eeef3  (release/2.1)
Author: Steffan Karger
Date:   Tue Aug 15 10:04:33 2017 +0200

     Fix bounds check in read_key()

     CVE: 2017-12166
     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <80690690-67ac-3320-1891-9fecedc6a1fa@...1435...>
     URL: https://www.mail-archive.com/search?l=mid&q=80690690-67ac-3320-1891-9fecedc6a1fa@...1435...
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZxFJzAAoJEIbPlEyWcf3yMoMP/16ULjZeoATgUyEFJFDnymiZ
xVpABNTnZ+vsFYjjTcx6RKXbGbvGZVmEqTFe5tke7CgeaVMyR13gtI7XjTscWlXK
KTZ9LdDK18cJ4dX/UmUpWoyt4wtEI0pPdcCx2T9uQXe3suYHz+iJscFwTfHZ6Jc6
HHE4PKc8137nfKGJANuT7mJFZ+z0EZBUwfeQqskO6RqOwTEn9AxlXpXEuTyAtYTp
e9WcX70aDWX9B5UfpyhBX7ztO5ItpLkGoL5VtYZkFi5VYBPrwJ9kOLuzDmaa27s3
H9MJWqbDDvTDyju+7jqc17mBcsr1LoisN0+uR+5N9qCsfeeMpVlEX/u/b7WGUNSN
OjlOqiqNsUI0OmWR6vueuByB8RFwJjqelL7GEr81o/RXzb9I33TN66L1SKMPPcS5
TtBSSjXkasYht3eYYxJBtnGwABQcpEFdwu2LWnZqDdTyr93DIlsQ+XokbalWllgH
ZHgs+sgQ4AJh7YG7vlvO95QQ984XVBbTFIC9mlOdffVu4ARGBuJfMz84aVxWx9Wt
lviSvMeXYdF9Nj0hKIk+ntLxXR0HCeFq3DbVxSpw56AlzZHypBD6xRfgmsMu1g4a
np0sYWGpzEvk5KE8NbbRtJUv0qxQ8bFU4otgJ+hcKwBvSEcZdu7KdzCeHUKq2AXw
2evGMbq03th94EP0D+M+
=eAY7
-----END PGP SIGNATURE-----

