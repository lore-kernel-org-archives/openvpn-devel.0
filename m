From: David Sommerseth <davids@...515...>
Date: Tue, 15 Aug 2017 15:48:38 +0200
Message-Id: <20170815134838.29506-1-davids@...515...>
In-Reply-To: <20170701112951.19119-1-steffan@...1856...>
References: <20170701112951.19119-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Deprecate --keysize
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

ACK.  The patch have been slightly adopted to git master and applied to
release/2.4.  In addition, the final deprecation was moved to v2.6.

Your patch has been applied to the following branches

commit ad178f01444d61e48fca83c4f0bc5d82270cee87  (master)
commit e2ab4958528a352c3ddad02446c10814afe68f6b  (release/2.4)
Author: Steffan Karger
Date:   Sat Jul 1 13:29:51 2017 +0200

     Deprecate --keysize

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20170701112951.19119-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15004.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZkvu0AAoJEIbPlEyWcf3ygK0QAIVaDf3bnuxx1HhiOZVj6tho
GejAD1sq3dSW3SRYfbvLtOpnr+LPVfbAvR203EeOJhj+2s3oaqrabI8GFH2r+xy4
NMgX1flrnjhv5bn1dJStDGNLAF//htb/YD9HxuOOgFuhqoHPsO8kzlULUzW+8PkZ
hDgqWAm/IPUKJb2sfTUMat4CZxjE6Bf7qpsR8Znt0ilcaUzxwlwkRIeP/buC4zNJ
MT3zzDfwGzEM6mxcNiNromc9TQl4Jjvpf6oNcYkDUu/RkUNvha3XsI39xr/FXFLS
/VaQuOs4cZl0fzlP217hMl4IZ3f0EYT7jUHHBNMz+sPfB+e9F9BKktoKS8qGV185
uIC20+YQsfkKHJKM32XqRoi7OFjIevbljrSS8QSqOx6hx28rDRAkrvcIGrvrEGPu
Og7XHM5KwvtsNo09ScZOhJEfdh3zWYlq7gdnXT1iCySwG4iQ2oAiiQj37wDcXwcG
lrKW6ekk8RGxB/BZkSNo0oSPDlftIE/Yg81JNwcCHmUMDSsQzlHJTA4EYyhBFMic
q4+OtqNp9n7xnUYzQxWpzKPUXZ8TYXTh4AQFVrHnYpLz2NJpytYjOiRZ+7kVa1oN
rHz51ifHfo7Xj9jI7GAhUcMEZIjmjaiPBbC6b5MbJvkTgDrEUo+Jq8ps2/456rVR
sx+X4/sifcGMFuoh235b
=UleN
-----END PGP SIGNATURE-----

