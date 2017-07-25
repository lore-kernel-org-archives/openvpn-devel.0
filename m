From: David Sommerseth <davids@...515...>
Date: Tue, 25 Jul 2017 17:24:43 +0200
Message-Id: <20170725152443.9409-1-davids@...515...>
In-Reply-To: <20170707102238.8781-1-a@...2181...>
References: <20170707102238.8781-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH applied] tls-crypt: avoid warnings when
 --disable-crypto is used
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

ACK as well.  Tested with --disable-crypto and no tls-crypt.c compiler
complaints any more.

Your patch has been applied to the following branches

commit 2dfbf62b6ace1eb39f1ae7126bc5530a541bed58  (master)
commit 8295f62f84be3dbc5203b9695d99a4f74fcb7295  (release/2.4)
Author: Antonio Quartulli
Date:   Fri Jul 7 18:22:38 2017 +0800

     tls-crypt: avoid warnings when --disable-crypto is used

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Steffan Karger <steffan@...1856...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20170707102238.8781-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15014.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZd2K5AAoJEIbPlEyWcf3ysZgP/3yh9FM0DsTOYJ0XGNZRzrHO
kHZfzkqLidjdsZMHKcp7UNtV9YgV2++vUbAptGZBC6ECLoHZHblPRUK4CrFFwL4d
ErvGBu4k3+3hz6SApGi62dUHBguT2gPAiF2bIHhWUy1yOQfF/3ycSZaWz/hVml1a
UF2hRUCCdObERP3Ho61LlCKeV+1HAjXyTOtb7JBFZ3UJD6vKBPSYeefZyojYx3Iw
Vsov9RUUAJE0+ZJJ7jINB9EYe7nCdEJ78iTG7PXfd90E98QCL7g9ThZtR0nwhqGv
ONmQDBghS0TBjB98cIml4G0mKMaVtCO5LxaC+lx776H3qZYw48himu0HD01/iNrQ
tieSVdBvNvPfDcL/44T19US5ra6FJLLoQELwcSzctf90QLhpo1OSOTxKKu7XRr7V
HwxQy/pWDFVbgDN5EpXJLL1H+0XHXpwifhZ07MfhPuzunB7lodocH7RsbuYxhSGD
TyWZbnC+yPUoRCdC5K6Rof5jW+NUbQCcgJ6Jlvee2gDsjZAnlFxxCQm7Bp2TMpBe
Et+HsKbWQf2Bl3lqc7+pMpuuELvputS8aoPhrCwH7JJN3bL/VdLQbpuu5YFGhG+6
BZnUqHcnOqzKL3HEZO5LEZQO+/xVqe7HsoRVF6Eir/bzJBM6bYSGV+0Tsuea/U7d
1vtIZc6hG/p5NuH2Pj42
=0ctS
-----END PGP SIGNATURE-----

