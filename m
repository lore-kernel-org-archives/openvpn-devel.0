From: David Sommerseth <davids@...515...>
Date: Tue, 15 Aug 2017 21:37:06 +0200
Message-Id: <20170815193706.18080-1-davids@...515...>
In-Reply-To: <20170701112208.18803-1-steffan@...1856...>
References: <20170701112208.18803-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Deprecate --no-replay
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
To: steffan@...1856...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

ACK.  Please send patch for git master removing this feature.  I
considered applying it to git master, as a way to track it. But decided not
to do that now.

Your patch has been applied to the release/2.4 branch.

commit e3da00918d2dd99c116f6da1a14a2a73b72829f4
Author: Steffan Karger
Date:   Sat Jul 1 13:22:08 2017 +0200

     Deprecate --no-replay

     Signed-off-by: Steffan Karger
     Acked-by: David Sommerseth
     Message-Id: <20170701112208.18803-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15003.html
     Signed-off-by: David Sommerseth


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZk01dAAoJEIbPlEyWcf3yTzoQAKR5rlvu5wf+TtXjluxO9CNx
q9Ausjy8C8C87ltHEPm2CgNcq3BywqCyaxxoy+yox97PGeCgQ1EBRkOtlnwBdrZi
9Ad3gnyNlYw0iX/oZ3A7MH1dr6jH8f2gTLcxdwcyvacmeDpS0Y2R31VFKJbYHMKX
9afXWqxkpkFhVvi1Mwph3RR+dTO8OSxmVExGKM1E1q5aSB3Vfsp2vk2qtlUyaij7
uOAS/TaBole5k2VUnwfMH5fdw6fBnosc2eRw+kqY3NdjQKE3TiH5MuwqnsP5tsbt
eW4Do5xT2kU+XgY2jp0dPI4ImD8aUfVYg0Ud54A4n0E0uf6KCkGCPkDBr5KhObiP
if+Yl5Zv3W2W5ZsN7tbB+IyZGJMoqghqG0a/fw8Ef4A6ZsH+aSCtgQyE/CoTvFA/
5I6q97EFQIiLsbyMAnk2Wb1IC1nxgO1HcHudOcGOtqLwz+ungHcdZQv6H5xecDDi
0YLteRG5sxM7CBxjOD3gs1nk+BbbtSp/DAFe3VNw+F0EVOCcmcuSGdBvW5ZwZcq8
FIrm6znVgvOklO+a0/jm0lYLSSiJmvhDh2zEK5ovFOD+Rw6KAodDoyz3d84oyRJG
A9mb+v/3WgqxDRuM+O173Hti9pHcv3zXmmF5e9tuQIOEQdXSliGG+UV7fRvhW9up
BemIFv02Qac9uW9yKFjJ
=HIXh
-----END PGP SIGNATURE-----

