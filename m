From: David Sommerseth <davids@...515...>
Date: Wed, 17 Apr 2019 22:10:33 +0200
Message-Id: <20190417201033.13348-1-davids@...515...>
In-Reply-To: <20181028145449.12676-1-steffan@...1856...>
References: <20181028145449.12676-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] cmocka: use relative paths
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

Acked-By: David Sommerseth <davids@...515...>

This didn't break anything on my systems, and changes makes sense.
I spotted another fix also sneaked in, replacing the incorrect
OPTIONAL_PKCS11_{LIBS,CFLAGS} with the correct
OPTIONAL_PKCS11_HELPER_{LIBS,CFLAGS}.


Your patch has been applied to the following branches

commit 4ded2deda0d6d33d38fbbd1f4cd4e9acc0836a89  (master)
commit 84a649bee961947343be2c47041a8ec9b37e29d1  (release/2.4)
Author: Steffan Karger
Date:   Sun Oct 28 15:54:49 2018 +0100

     cmocka: use relative paths

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20181028145449.12676-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17849.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJct4ghAAoJEIbPlEyWcf3yDboP/j6hYYlcbAibt8VYCaW9fCdo
MUteapG0gP+aLsgfcLf5MAj3ArY1hWN1E2QRMaHbimyzjHG7HvoZZRbZ0TXH+adJ
7euIRQbngG/eGUozrxaYc4rVDANlY578K7rKsfsJTbl0U5JmMckmMfrN9o3dvTaY
x1mtoU/9tzrKKiBUNRRF4y6IIAnGl5ll3MAA5J05i6ffoD0EekDOgOHHVwOut2un
Uah1DmpKrZzL6MWuuwFG0i5x1yh6THql+usLvoVXWmzY8AUSOgfHyPNg7g0hgqx5
K2jJhuc26aLfgxwSEPOc6z41xt7lHGpjOTwfLyGx8Z0OGCykEDLwtnnea429gC48
8MvQYTefpPX7OoTJ81KLg6By1fVv9j/aGL83/PEtm8YqxZnypZRk53kj5wXNn4fJ
ovs3nmQwSuwvDPIsfa636e+ZzKc9wAMI7O6BIx/JJ4DfVFe7dIuChGMnbJsDJ3dq
J063yXqwleeoNUfXrDBHgrMdvXJe40nEjqAJQ5nzcxA6diu9gvJeSzD+ZaEpfQ6o
ZS8lXlHeREqNaLepx+HXQGVu69SlGNb8nZhGUH5qC6Q+eghfGTmoqai25cJJzeJV
3xYBOea4k5euvLn850bf6dGvzuD8kdgmaxyd1vOJlEG1bpvz2Dy7l+rRF0tiF+FC
K92L6CRrNdjMEVYnMXjy
=ogEA
-----END PGP SIGNATURE-----

