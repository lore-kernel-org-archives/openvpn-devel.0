From: David Sommerseth <davids@...515...>
Date: Mon, 14 Aug 2017 15:53:32 +0200
Message-Id: <20170814135332.21172-1-davids@...515...>
In-Reply-To: <20170725210234.5673-1-steffan@...1856...>
References: <20170725210234.5673-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Move create_temp_file() out of
 #ifdef ENABLE_CRYPTO
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

ACK.  This makes sense, code looks good and passes initial tests.

Your patch has been applied to the following branches

commit cd5a74d0d7c6347b31e261e98ca8984819e594df  (master)
commit a91c38fbabf6f949990ef8a3801d56225a47a33f  (release/2.4)
Author: Steffan Karger
Date:   Tue Jul 25 23:02:34 2017 +0200

     Move create_temp_file() out of #ifdef ENABLE_CRYPTO

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20170725210234.5673-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15146.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZkatbAAoJEIbPlEyWcf3yjUQP/1yZE+5cYLEdBYrkbv61p1wY
f7EG3F29hdCYEYHS1rTvYQbPZFy48YJL5mqvs6IKemQxVIYoEFkCF5KLdYIU6ZlU
1n6Km+yUqeYpU3Tm07Yl+20qCv3+H9FAMJkDjosoh6BIuF8HJD7NsAmDFoY23X2k
TXicBKu9zgIHszzFhYQkhQBIBxhpVirZ2r2TqgXOmiz/rbRtmRsHeqFEEcfWv/mT
YULxqREKDPTWKHsH/s1JbwoWwrhkzeeYdxoaYs6/qN7zuNj5bmfxfvzJXmtbRlH3
mi/fCtgxq9OJvokUpfSNVoKwf90VGEVy+occziE7KdOmWNCh4QpPBVt27PdloEmc
dbbDES7YSndiaHXYoU9I15SP9pGgUI8DmUc9SU9PUPSGSdVG+aRhw4DzY400EQRL
jTzdiOZB33xWJivKuxWXM0kWbdu1Nga4Q/aTwJCLaa+Xcuh/mdMZMCuPKfNiRTFZ
iU4ZIqSGi84h1pt9azWftI9+7fLIaAsdmwhnQBy9rGz5afzC8rf2TlOmSTYzwdqA
fI6TVlu9JosMxDnUtXN5NANRVB79JVYaCVxshCajDBUe4m/j1Ywz5R/PLqMk29zt
WBbNdMsVBijJ1DhMFqZDxrBCyKh9OwPHRawdonRU4MD53aXbfBNRR7kCrCAcd3Rt
/qnAV7+hg5KxbpF0UrC9
=CjJG
-----END PGP SIGNATURE-----

