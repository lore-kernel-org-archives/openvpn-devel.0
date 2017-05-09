From: David Sommerseth <davids@...515...>
Date: Tue,  9 May 2017 22:04:54 +0200
Message-Id: <20170509200454.22705-1-davids@...515...>
In-Reply-To: <1494359069-13824-1-git-send-email-selva.nair@...277...>
References: <1494359069-13824-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH applied] In auth-pam plugin clear the
	password after use
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

ACK.  Looking good now.  Tests are good too, and the password wiping works
as expected.

Your patch has been applied to the following branches

commit f403b9a2bf93f0fa35ee8316c2d219f48638a3e5  (master)
commit 4702cf5a898f33693f4f705038e1b4f2568bde71  (release/2.4)
Author: Selva Nair
Date:   Tue May 9 15:44:29 2017 -0400

     In auth-pam plugin clear the password after use

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1494359069-13824-1-git-send-email-selva.nair@...277...>
     URL: http://www.mail-archive.com/search?l=mid&q=1494359069-13824-1-git-send-email-selva.nair@...277...
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZEiDkAAoJEIbPlEyWcf3yqlgP/RtbbUqmtZ+4GOTSe7bZO4Hp
s07SovaN+xAfNgEa7Gr1UfrfDVkmYjkshtlBTn7CP4arC/dRyI7nKZzbdzg75m9/
krCIZgfELrrWKK4dnx+oe78LCxwM4aSA2F/bmKcf4gjbAPb+H/OK2J3OpbAy2/u8
fVTvt+uq0yzDTHIP77iCAuyC+Ss5248D4/Tc2s8ahyqi06ozKzsM3+FY0nuzVRk6
Qml8CyiwiBqCeO6RC4uVst/9vr9A5scyDb1te2tHuxU/Ue8AA7imxrF1OXqmCF0U
I/0x16+dWLhPBfDp1ISPQ072uejJynTrWvRStckiC5uvVrY5CHxDC1IhwwUg9cml
zYesKzNhXJfXp6BGTr7YOKSLrSOpSRLSmRDhzgCzQ4N2Ov877Yx46uNzfv5D+17D
GHpZXgGyfqKs8NMTr9U+fcAgKTe6cxE/q/NAtdK83L4Xi6L3hkm3vksy7zUQM/xf
mkF3fRkKew2gnx4AieGWNTXL3etzeb+yQUvkWwzScldgB2xJ9zNfyryJ2aa3lL7g
M9clMooBOxCP51heWiVse/YvcuWb4SuqzKff57RH/MgQBWUELokTJSJqL40Eege5
2m1RGBqo/u3HOjycrmVLm8nqMicAIR0QWBhfwrNQ4nnS6GBQv7Aj+2U4B5+871ch
3AsqMrSR3hIAWonO5x42
=23Zp
-----END PGP SIGNATURE-----

