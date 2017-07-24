From: David Sommerseth <davids@...515...>
Date: Mon, 24 Jul 2017 15:27:15 +0200
Message-Id: <20170724132715.9094-1-davids@...515...>
In-Reply-To: <20170707140108.31612-1-a@...2181...>
References: <20170707140108.31612-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH applied] management: preserve
 wait_for_push field when asking for user/pass
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
To: a@...2181...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

ACK.  Tested and glared at code.  This matches quite well the analyzsis
I had done before Antonio took over and completed.  And it works as expected.


Your patch has been applied to the following branches

commit 3322c558fa742cb823fa919f682486973abc4f8e  (master)
commit e7ae4040efc5c48e00374f8863da58eef32e0709  (release/2.4)
Author: Antonio Quartulli
Date:   Fri Jul 7 22:01:08 2017 +0800

     management: preserve wait_for_push field when asking for user/pass

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20170707140108.31612-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15015.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZdfWwAAoJEIbPlEyWcf3yO8wQAIIkYjGfx0NjA/lbjm1qnEfq
I4pc9sDgNGPo9NF5hWz+NDfkK6fxVjakW0fRJZe4HLXxrsSQIh64VX3BpfZglrIz
gGvmbxrts9/TnXTwGhMOGZW/3GjwmhmUXT8yCxR0K8rOi41NNF8D6HmtDUxCI+Pa
Tzfh5ddHgJu4E+kd+F1+k0CO6dyTyZCjuVSpT/MufGpZ0YcWr86F9xdtuzrprJda
+FTpjpXD8eD8uHP3WTcrO+rGgWHkjoRErO+nlFwPSVH7Ob/Oc9xWL5ptjEmig/gW
xBGRn+Sxp1GmDn326Wd4WdIYFqgdYlzs27/rR6xhDlmF9ger5EISYoETQuso5J2s
GFKxjEV8IK8TJdSK8Fm5DyQNaOdTV5rwssUn6I6XDqJRDW4yNoyEEnVZKphYvTis
eYBm2ckTjEvAs1dR9Of8LQUm/53aDwwzrkH/7pcZeo0rLIS05gpk6FUYtFFS1g8r
yPxV6rrcCbDPozdXSiH0fF30jQDA/bmTkJJjJj54nDVPe4FAWNUvU4Kw7TH95O6c
tEADa2hQl2kQwKY1eRVkA/PnA9rKx65WN1V8MU9NSC/gLuNC/IBqd90QL/aZ0l/Z
I6ANDhbcNh0NkhFC+dQkS3InI/aFed0A1GpTNtzGswVRIpJ3LUGYGTKb8cQ0xr5c
e2l7cIMeTzme9pyaybfu
=BxCy
-----END PGP SIGNATURE-----

