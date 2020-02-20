From: David Sommerseth <davids@...515...>
Date: Thu, 20 Feb 2020 19:19:47 +0100
Message-Id: <20200220181951.7603-3-davids@...515...>
In-Reply-To: <20200220181951.7603-1-davids@...515...>
References: <20200220181951.7603-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] Add gc_arena to struct argv to
 save allocations
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
To: openvpn-devel@lists.sourceforge.net, Heiko Hund <heiko.hund@...1489...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Your patch has been applied to the master branch

commit e7500875efe03937fc222d737050789f97c30c03
Author: Heiko Hund
Date:   Thu Feb 6 14:21:02 2020 +0100

     Add gc_arena to struct argv to save allocations

     Signed-off-by: Heiko Hund <heiko.hund@...1489...>
     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20200206132103.15977-4-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19376.html


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJeTqiqAAoJEIbPlEyWcf3y/W4P/RmiDlqxefz7bcvn6FFXuqhX
V4z4S54+J/GyvTtrOZhVUsaQ0/J2i6R6qvKdTd87jUOYhrkwd5rfN3D10WCizYhH
reGU5nTiMjhIKeCDfaI2gRN0XNXngL7bxFrv+1ND6wsJe1b4dBoqqU+YvSfEusI+
IPD/YWe1QlAW2oYzFAnZL8rx3FZwKGm2BMA0gC3bgEeTwSdh6R9K4PPxkfUiFe/e
NgC5N5mAspH6JMARIfWxaqqRM3QysOXruKshvWs+L4N+Y4Rp96ZOm7U6QWK2FXPZ
PI66l/GEzhY2PyQj3TpZrTM5+ibD8nOnAyMqceqA6j+mkhggpR0V3gJLRrO/KJM7
J/XTpFrUbnkGxoHWCUNsc495cQedm76cg+sLK73eF0FKIhpAsSvWh1W1pwVAmAtO
jRL7g1Xtc+AdM5j/m02dK+jCxgGfIaqobptRGdMGsi2KwJjUxrQeag11+5zLg/x/
GME52Xzf7gHcLw0dZPYxflA+ZCtA/zh6Xfi0ab9J5oM3N+LmOzhUeJGX4WaCRgod
cNWD+kYLXWNlyOWPTNm/HhSSgFS6w3KlZ+pezAdp8A40kOtTGLXUN7XRQVpsVUH4
ZZyYb05XiZnDjFmcj547WNQPCzSSyok+mt8nw/yZdFs6HAyqY7XrI8iWmb6zET1Y
Ans8eFG2HBWsXcOhbzHX
=iJcm
-----END PGP SIGNATURE-----

