From: David Sommerseth <davids@...515...>
Date: Thu,  7 Sep 2017 01:03:39 +0200
Message-Id: <20170906230339.23053-1-davids@...515...>
In-Reply-To: <20170816125504.21181-1-a@...2181...>
References: <20170816125504.21181-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH applied] route: avoid definition of
 unused variables in certain configurations
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
To: antonio@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

ACK.  Looks good to me, but I haven't tested on all kind of platforms so
if buildbot explodes, we'll take it from there.

Your patch has been applied to the following branches

commit 22e75ca1a88b83e83a12b7d7d0095651f547411d  (master)
commit 3c4e2a39de509bb445a86fba9573f07880ac541c  (release/2.4)
Author: Antonio Quartulli
Date:   Wed Aug 16 20:55:04 2017 +0800

     route: avoid definition of unused variables in certain configurations

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Reviewed-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20170816125504.21181-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15272.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsH7AAAoJEIbPlEyWcf3yaWYQALBHdv7J4/o8B20Mx4OksLyI
f0Pg0W64T44k5aDmyn+XzpDC4kWOgP5xrabvzXno1wfzn1llru3HTfL+DlGK8IQm
8d/YWid3gpC/pvOOpLcSqzmaxXocFL2BH7CEkhxJeM4DLV1hGUGe93XqSQ7uV9Fr
MOPQaB0bhnbvRYRuqi3gG26zIL0sn7080eVKHPoAMY+ACHQxluidmDKwvemKkJh+
l+2ufn/zx3wKP7ByBh8lnCtGIHfkCmlraIZt/urunlizG6Vn3dFgBYB9EpCeB65e
9nfCzi5MX2TMBVyLU3XS1cWPTe9Qj6mmejN6YJLvWO8KBj9G5p9UdHtG0tnqJ06n
2dhhhGl7jLLZ9IbKhC+LnsB0f+z3qvQegxdDoI3Sb9vwltMDqs5PCOjmL7tF1ARY
0sl6oSucVvyf9UDTYvhzg3dkKQkOL0u4wSVSQsQeVDvu2ggIPjVvLia6uf8kTpw9
AKl/2wO5NMZBVanpFe2FWaLgsJ1viROO0vrcmoJoEgDYFOwrSo/P17NcnAv32aTR
hLV+ts6+D+3uUbQVwwxeVcV7zc67i0Tj+pF/xnReSyCLogXkFTRF1hYga4rjs1h6
TrViGGYdU7qN5lq38zdh8lQSeTroaOIC1DvLGUB4YWsc9nHl96mqhuGW91lxft0e
vfn55e+NRTi1KQ8nGFtQ
=VBW9
-----END PGP SIGNATURE-----

